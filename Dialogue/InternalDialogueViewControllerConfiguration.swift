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

extension InternalDialogueViewControllerConfiguration: InternalDialogueViewControllerDelegate {
    func didReply(with message: String) {
        add(.replied(message))
    }
    
    func didReceive(_ message: String) {
        add(.received(message))
        
        delegate?.didReceive(message)
    }
    
    private func add(_ message: Message) {
        messages.append(message)
        
        print(message)
    }
}
