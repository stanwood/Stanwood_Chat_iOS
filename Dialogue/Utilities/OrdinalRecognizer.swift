//
//  OrdinalRecognizer.swift
//  Dialogue
//
//  Created by Maciek on 19.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import Foundation

class OrdinalRecognizer {
    private let messages: [Message]
    
    init(for messages: [Message]) {
        self.messages = messages
    }
    
    func ordinalTypeForMesage(at index: Int) -> MessageCellViewModel.OrdinalType? {
        guard index < messages.count else { return nil }
        
        if messages.count == 1 {
            return .standalone
        }
        else {
            let message = messages[index]
            
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
