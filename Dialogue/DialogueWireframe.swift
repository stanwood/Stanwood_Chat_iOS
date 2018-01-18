//
//  DialogueWireframe.swift
//  Dialogue
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import Foundation

public class DialogueWireframe {
    public static func instantiateDialogueViewController(
        with delegate: DialogueViewControllerDelegate
        ) -> DialogueViewController {
        
        let viewController = DialogueViewController.loadFromStoryboard()
        
        let internalConfiguration = InternalDialogueViewControllerConfiguration(decorating: delegate)
        viewController.delegate = internalConfiguration
        viewController.dataSource = internalConfiguration
        
        return viewController
    }
}
