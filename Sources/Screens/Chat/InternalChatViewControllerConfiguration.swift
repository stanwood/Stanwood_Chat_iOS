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

internal class InternalChatViewControllerConfiguration {
    private var messages: [Message] = []
    
    private let delegate: ChatViewControllerDelegate?
    
    init(decorating delegate: ChatViewControllerDelegate? = nil) {
        self.delegate = delegate
    }
}

extension InternalChatViewControllerConfiguration: InternalChatViewControllerDataSource {
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
        
        let ordinalType = OrdinalTypeRecognizer(for: messages).ordinalTypeForMesage(at: index)
        
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
