//
//  InternalChatViewControllerConfiguration.swift
//  Chat
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

public protocol ChatStyleProviding {
    func textColor(for messageType: MessageType) -> UIColor
    func backgroundColor(for messageType: MessageType) -> UIColor
}

internal class InternalChatViewControllerConfiguration {
    private var messages: [Message] = []
    
    private let delegate: ChatViewControllerDelegate?
    private let styleProvider: ChatStyleProviding?
    
    init(
        decorating delegate: ChatViewControllerDelegate? = nil,
        with styleProvider: ChatStyleProviding? = nil
        ) {
        
        self.delegate = delegate
        self.styleProvider = styleProvider
    }
}

extension InternalChatViewControllerConfiguration: InternalChatViewControllerDataSource {
    var penultimateMessageIndex: Int? {
        guard messages.count > 1 else { return nil }
        
        return messages.count - 2
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
        
        let ordinalType = OrdinalTypeRecognizer(for: messages).ordinalTypeForMesage(at: index)
        
        return MessageCellViewModel(
            text: message.text,
            sender: .sender(for: message),
            ordinalType: ordinalType ?? .standalone,
            textColor: styleProvider?.textColor(for: message.type) ?? UIColor.white,
            backgroundColor: styleProvider?.backgroundColor(for: message.type) ?? UIColor.black
        )
    }
}

extension MessageCellViewModel.Sender {
    static func sender(for message: Message) -> MessageCellViewModel.Sender {
        switch message {
        case .received(_):
            return .user
        case .replied(_):
            return .app
        }
    }
}

extension InternalChatViewControllerConfiguration: InternalChatViewControllerDelegate {
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
