//
//  AppDelegate.swift
//  Demo
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

import Dialogue

class DialogueViewControllerConfiguration {
    weak var viewController: DialogueViewController!
}

extension DialogueViewControllerConfiguration: DialogueViewControllerDelegate {
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
        
        let configuration = DialogueViewControllerConfiguration()
        let viewController = DialogueWireframe.instantiateDialogueViewController(
            with: configuration
        )
        configuration.viewController = viewController

        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}
