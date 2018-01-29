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
    
    func messageCell(
        at index: Int,
        providedForReuseBy provider: ReusableCellProviding
        ) -> UITableViewCell {
        
        let message = messages[index]
        let cellType = typeOfCell(at: index)
        if cellType == MessageCell.self {
            let reusableCell: MessageCell = provider.provideReusableCell(for: index)
            prepareMessageCell(reusableCell, at: index, with: message)
            
            return reusableCell
        }
        
        return UITableViewCell()
    }
    
    private func typeOfCell(at index: Int) -> UITableViewCell.Type {
        return MessageCell.self
    }
    
    private func prepareMessageCell(
        _ reusableCell: UITableViewCell,
        at index: Int,
        with message: Message
        ) {
        
        guard let cell = reusableCell as? MessageCell else { return }
        
        let ordinalType = OrdinalTypeRecognizer(for: messages).ordinalTypeForMesage(at: index)
        let messageType = message.type
        
        cell.prepare(
            with: MessageCellViewModel(
                textContent: message.textContent,
                alignment: .alignment(for: messageType),
                ordinalType: ordinalType ?? .standalone,
                textColor: styleProvider?.textColor(for: messageType) ?? UIColor.white,
                backgroundColor: styleProvider?.backgroundColor(for: messageType) ?? UIColor.black
            )
        )
    }
}

extension MessageCellViewModel.Alignment {
    static func alignment(for messageType: MessageType) -> MessageCellViewModel.Alignment {
        switch messageType {
        case .received:
            return .right
        case .replied:
            return .left
        }
    }
}

extension InternalChatViewControllerConfiguration: InternalChatViewControllerDelegate {
    func didReply(with textContent: TextContent) {
        add(.replied(textContent))
    }
    
    func didReceive(_ text: String) {
        add(.received(text))
        
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didReceive(text)
        }
    }
    
    private func add(_ message: Message) {
        messages.append(message)
    }
}
