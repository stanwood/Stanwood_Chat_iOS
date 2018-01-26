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
    func didReceive(_ text: String) {
        let attributedString = NSMutableAttributedString(string: "Thx for your message: \(text)")
        let font = UIFont(name: "verdana-bold", size: 18.0)
        attributedString.addAttribute(NSAttributedStringKey.font, value:font!, range: NSRange(location: 0, length: 5))
        attributedString.addAttribute(NSAttributedStringKey.strokeColor, value: UIColor.green, range: NSRange(location: 0, length: 5))
        
        viewController.reply(with: .attributedString(attributedString))
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
