//
//  InternalDialogueViewControllerConfiguration.swift
//  Dialogue
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import Foundation

enum Message {
    case received(String)
    case replied(String)
}

internal class InternalDialogueViewControllerConfiguration {
    private var messages: [Message] = []
    
    private let delegate: DialogueViewControllerDelegate?
    
    init(decorating delegate: DialogueViewControllerDelegate? = nil) {
        self.delegate = delegate
    }
}

extension InternalDialogueViewControllerConfiguration: InternalDialogueViewControllerDataSource {
    func numberOfMessages() -> Int {
        return messages.count
    }
    
    func messageCellViewModel(at index: Int) -> MessageCellViewModel {
        let message = messages[index]
        
        var text = ""
        switch message {
        case let .received(_text):
            text = _text
        case let .replied(_text):
            text = _text
        }
        
        return MessageCellViewModel(
            text: text,
            sender: MessageCellViewModel.MessageSender.sender(for: message)
        )
    }
}

extension MessageCellViewModel.MessageSender {
    static func sender(for message: Message) -> MessageCellViewModel.MessageSender {
        switch message {
        case .received(_):
            return MessageCellViewModel.MessageSender.user
        case .replied(_):
            return MessageCellViewModel.MessageSender.app
        }
    }
}

extension InternalDialogueViewControllerConfiguration: InternalDialogueViewControllerDelegate {
    func didReply(with message: String) {
        add(.replied(message))
    }
    
    func didReceive(_ message: String) {
        add(.received(message))
        
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didReceive(message)
        }
    }
    
    private func add(_ message: Message) {
        messages.append(message)
    }
}
