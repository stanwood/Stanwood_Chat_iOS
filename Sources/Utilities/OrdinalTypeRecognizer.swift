//
//  OrdinalRecognizer.swift
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

//  The name and place is not right
class OrdinalTypeRecognizer {
    private let messages: [Message]
    
    init(for messages: [Message]) {
        self.messages = messages
    }
    
    //  this coupling to MessageCellViewModel.OrdinalType looks pretty bad...
    func ordinalTypeForMesage(at index: Int) -> MessageCellViewModel.OrdinalType? {
        guard index < messages.count else { return nil }
        
        if messages.count == 1 {
            return .standalone
        }
        else {
            let message = messages[index]
            
            //  extract to Sequence extension
            var previousMessage: Message? = nil
            if index > 0 {
                previousMessage = messages[index - 1]
            }
            
            var nextMessage: Message? = nil
            if index < messages.count - 1 {
                nextMessage = messages[index + 1]
            }
            
            switch (previousMessage, message, nextMessage) {
            case (nil, _, nil):
                return .standalone
            
            case let (previousMessage?, message, nextMessage?)
                where previousMessage.isOfTheSameType(as: message)
                    && message.isOfTheSameType(as: nextMessage):
                
                return .middleInTheSerie
                
            case let (_, message, nextMessage?)
                where message.isOfTheSameType(as: nextMessage):
                
                return .firstInTheSerie
                
            case let (nil, message, nextMessage?)
                where message.isOfTheSameType(as: nextMessage):
                
                return .firstInTheSerie

            case let (previousMessage?, message, _) where
                previousMessage.isOfTheSameType(as: message):
                
                return .lastInTheSerie
                
            case let (previousMessage?, message, _)
                where !previousMessage.isOfTheSameType(as: message):
                
                return .standalone
                
            case let (nil, message, nextMessage?)
                where !message.isOfTheSameType(as: nextMessage):
                
                return .standalone
            
            default:
                return nil
            }
        }
    }
}
