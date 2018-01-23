//
//  AppDelegate.swift
//  Demo
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

import Chat

class ChatViewControllerConfiguration {
    weak var viewController: ChatViewController!
}

extension ChatViewControllerConfiguration: ChatViewControllerDelegate {
    func didReceive(_ message: String) {
        viewController.reply(with: "Thx for your message: \(message)")
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
        ) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let configuration = ChatViewControllerConfiguration()
        let viewController = ChatWireframe.instantiateChatViewController(
            with: configuration
        )
        configuration.viewController = viewController

        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}
