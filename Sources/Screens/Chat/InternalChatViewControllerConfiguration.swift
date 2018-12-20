//
//  InternalChatViewControllerConfiguration.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2018 Stanwood GmbH (www.stanwood.io)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
