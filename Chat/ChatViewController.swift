//
//  ChatViewController.swift
//  Chat
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

internal protocol InternalChatViewControllerDataSource {
    
}

public protocol ChatViewControllerDelegate {
    func didSend(_ message: String)
}

internal protocol InternalChatViewControllerDelegate: ChatViewControllerDelegate {
    func didReply(with message: String)
}

public class ChatViewController: UIViewController {
    static func loadFromStoryboard() -> ChatViewController {
        return UIStoryboard(name: "Chat", bundle: Bundle(for: ChatViewController.self))
            .instantiateInitialViewController() as! ChatViewController
    }
    
    @IBOutlet private weak var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var textField: UITextField!
    
    var dataSource: InternalChatViewControllerDataSource?
    var delegate: InternalChatViewControllerDelegate?
    
    @IBAction private func sendDidTap() {
        guard let message = textField.text, message != "" else { return }
        
        send(message)
        
        textField.text = nil
    }
    
    public func reply(with message: String) {
        delegate?.didReply(with: message)
    }
    
    private func send(_ message: String) {
        delegate?.didSend(message)
    }
}
