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
    
    func isOfTheSameType(as message: Message) -> Bool {
        switch (self, message) {
        case (.received(_), .received(_)):
            fallthrough
        case (.replied(_), .replied(_)):
            return true
        default:
            return false
        }
    }
}

internal class InternalDialogueViewControllerConfiguration {
    private var messages: [Message] = []
    
    private let delegate: DialogueViewControllerDelegate?
    
    init(decorating delegate: DialogueViewControllerDelegate? = nil) {
        self.delegate = delegate
    }
}

extension InternalDialogueViewControllerConfiguration: InternalDialogueViewControllerDataSource {
    var penultimateMessageIndex: Int? {
        guard messages.count > 1 else { return nil }
        
        return messages.count - 1
    }
    
    var shouldReloadPenultimateMessage: Bool {
        guard let penultimateMessageIndex = penultimateMessageIndex else { return false }
        
        let lastMessage = messages.last!
        let penultimateMessage = messages[penultimateMessageIndex]

        return lastMessage.isOfTheSameType(as: penultimateMessage)
    }
    
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
        
        let ordinalType = OrdinalRecognizer(for: messages).ordinalTypeForMesage(at: 0)
        
        return MessageCellViewModel(
            text: text,
            sender: MessageCellViewModel.Sender.sender(for: message),
            ordinalType: ordinalType ?? .standalone
        )
    }
}

extension MessageCellViewModel.Sender {
    static func sender(for message: Message) -> MessageCellViewModel.Sender {
        switch message {
        case .received(_):
            return MessageCellViewModel.Sender.user
        case .replied(_):
            return MessageCellViewModel.Sender.app
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
