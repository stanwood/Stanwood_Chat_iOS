//
//  DialogueViewController.swift
//  Dialogue
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

internal protocol InternalDialogueViewControllerDataSource: class {
    func numberOfMessages() -> Int
    func messageCellViewModel(at index: Int) -> MessageCellViewModel
}

public protocol DialogueViewControllerDelegate: class {
    func didReceive(_ message: String)
}

internal protocol InternalDialogueViewControllerDelegate: DialogueViewControllerDelegate {
    func didReply(with message: String)
}

public class DialogueViewController: UIViewController {
    static func loadFromStoryboard() -> DialogueViewController {
        return UIStoryboard(name: "Dialogue", bundle: Bundle(for: DialogueViewController.self))
            .instantiateInitialViewController() as! DialogueViewController
    }
    
    @IBOutlet private weak var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var textField: UITextField!
    
    var dataSource: InternalDialogueViewControllerDataSource?
    var delegate: InternalDialogueViewControllerDelegate?
    
    private var keyboardHandler: KeyboardHandler!
    
    @IBAction private func sendDidTap() {
        guard let message = textField.text, message != "" else { return }
        
        send(message)
        
        textField.text = nil
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardHandler = KeyboardHandler(
            withBottomConstraint: bottomLayoutConstraint,
            andAnimations: { self.view.layoutIfNeeded() }
        )
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    public func reply(with message: String) {
        delegate?.didReply(with: message)
        
        reloadTableView()
    }
    
    private func send(_ message: String) {
        delegate?.didReceive(message)
        
        reloadTableView()
    }
    
    private func reloadTableView() {
        guard let dataSource = dataSource else { return }
        
        tableView.reloadData()
        tableView.scrollToRow(
            at: IndexPath(row: dataSource.numberOfMessages() - 1, section: 0),
            at: UITableViewScrollPosition.bottom,
            animated: true
        )
    }
}


extension DialogueViewController: UITableViewDataSource {
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        guard let dataSource = dataSource else { return cell }
        
        cell.prepare(with: dataSource.messageCellViewModel(at: indexPath.row))
        
        return cell
    }
}
