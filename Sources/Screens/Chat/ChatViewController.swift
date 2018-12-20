//
//  ChatViewController.swift
//  Chat
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

internal protocol InternalChatViewControllerDataSource: class {
    var penultimateMessageIndex: Int? { get }
    var shouldReloadPenultimateMessage: Bool { get }
    
    func numberOfMessages() -> Int
    func messageCell(
        at index: Int,
        providedForReuseBy provider: ReusableCellProviding
        ) -> UITableViewCell
}

public protocol ChatViewControllerDelegate: class {
    func didReceive(_ text: String)
}

internal protocol InternalChatViewControllerDelegate: ChatViewControllerDelegate {
    func didReply(with textContent: TextContent)
}

public class ChatViewController: UIViewController {
    static func loadFromStoryboard() -> ChatViewController {
        return UIStoryboard(name: "Chat", bundle: Bundle(for: ChatViewController.self))
            .instantiateInitialViewController() as! ChatViewController
    }
    
    @IBOutlet private weak var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var textView: UITextView!
    
    var dataSource: InternalChatViewControllerDataSource?
    var delegate: InternalChatViewControllerDelegate?
    
    private var keyboardHandler: KeyboardHandler!
    private var keepingAtTheBottomOffsetCalculator: KeepingAtTheBottomOffsetCalculator!
    
    private var tableViewBottomOffset: CGFloat {
        return view.frame.size.height - tableView.frame.size.height
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardHandler = KeyboardHandler(
            withBottomConstraint: bottomLayoutConstraint,
            andAnimations: { [unowned self] in
                self.view.layoutIfNeeded()
                self.tableView.contentOffset = self.keepingAtTheBottomOffsetCalculator.calculate()
            }
        )
        
        keepingAtTheBottomOffsetCalculator = KeepingAtTheBottomOffsetCalculator(for: tableView)
    }
    
    public func reply(with textContent: TextContent) {
        delegate?.didReply(with: textContent)
        
        insertNewRow()
        scrollToTheBottom()
    }
    
    private func send(_ message: String) {
        delegate?.didReceive(message)
        
        insertNewRow()
        reloadPenultimateRowIfNeeded()
        scrollToTheBottom()
        
        textView.text = nil
    }
    
    private func reloadPenultimateRowIfNeeded() {
        guard let dataSource = dataSource else { return }
        guard dataSource.shouldReloadPenultimateMessage else { return }
        guard let penultimateRowIndex = dataSource.penultimateMessageIndex else { return }
        
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadRows(
                at: [IndexPath(row: penultimateRowIndex, section: 0)],
                with: UITableViewRowAnimation.fade
            )
        }
    }
    
    private func insertNewRow() {
        guard let dataSource = dataSource else { return }
        
        let insertedRowIndex = dataSource.numberOfMessages() - 1
        tableView.beginUpdates()
        tableView.insertRows(
            at: [IndexPath(row: insertedRowIndex, section: 0)],
            with: .fade
        )
        tableView.endUpdates()
    }
    
    private func scrollToTheBottom() {
        guard let dataSource = dataSource else { return }
        guard dataSource.numberOfMessages() > 0 else { return }
        
        let lastRowIndex = dataSource.numberOfMessages() - 1
        DispatchQueue.main.async { [unowned self] in
            self.tableView.scrollToRow(
                at: IndexPath(row: lastRowIndex, section: 0),
                at: UITableViewScrollPosition.bottom,
                animated: true
            )
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfMessages() ?? 0
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
        ) -> UITableViewCell {
        
        guard let dataSource = dataSource else { return UITableViewCell() }
        
        return dataSource.messageCell(at: indexPath.row, providedForReuseBy: tableView)
    }
}

extension ChatViewController: UITextViewDelegate {
    public func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
        ) -> Bool {
        
        if text == "\n" {
            guard let message = textView.text, message != "" else { return false }
            
            send(message)
            
            return false
        }
        
        return true
    }
}

extension ChatViewController: UIStackViewDelegate {
    func didLayoutSubViews() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.contentOffset = self?.keepingAtTheBottomOffsetCalculator.calculate() ?? <#default value#>
        }
    }
}
