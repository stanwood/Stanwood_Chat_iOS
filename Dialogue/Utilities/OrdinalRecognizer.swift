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
            if index < messages.count - 1 {
                return .firstInTheSerie
            }
            else {
                return .lastInTheSerie
            }
        }
    }
}
