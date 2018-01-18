//
//  DialogueViewController.swift
//  Dialogue
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

internal protocol InternalDialogueViewControllerDataSource: class {
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
    
    weak var dataSource: InternalDialogueViewControllerDataSource?
    weak var delegate: InternalDialogueViewControllerDelegate?
    
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
    }
    
    public func reply(with message: String) {
        delegate?.didReply(with: message)
    }
    
    private func send(_ message: String) {
        delegate?.didReceive(message)
    }
}
