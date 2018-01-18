//
//  InternalChatViewControllerConfiguration.swift
//  Chat
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import Foundation
internal class InternalChatViewControllerConfiguration {
    private let delegate: ChatViewControllerDelegate?
    
    init(decorating delegate: ChatViewControllerDelegate? = nil) {
        self.delegate = delegate
    }
}

extension InternalChatViewControllerConfiguration: InternalChatViewControllerDelegate {
    func didReply(with message: String) {
    }
    
    func didSend(_ message: String) {
        
        delegate?.didSend(message)
    }
}
