//
//  ChatWireframe.swift
//  Chat
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import Foundation

public class ChatWireframe {
    public static func instantiateChatViewController(
        with delegate: ChatViewControllerDelegate? = nil,
        and styleProvider: ChatStyleProviding? = nil
        ) -> ChatViewController {
        
        let viewController = ChatViewController.loadFromStoryboard()
        
        let internalConfiguration = InternalChatViewControllerConfiguration(
            decorating: delegate,
            with: styleProvider
        )
        
        viewController.delegate = internalConfiguration
        viewController.dataSource = internalConfiguration
        
        return viewController
    }
}
