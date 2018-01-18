//
//  KeyboardHandler.swift
//  Dialogue
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

class KeyboardHandler {
    private let bottomConstraint: NSLayoutConstraint
    private let animate: () -> Void
    
    init(
        withBottomConstraint bottomConstraint: NSLayoutConstraint,
        andAnimations animate: @escaping () -> Void
        ) {
        
        self.bottomConstraint = bottomConstraint
        self.animate = animate
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didReceive(notification:)),
            name: NSNotification.Name.UIKeyboardWillChangeFrame,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func didReceive(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        let animationCurveRaw = animationCurveRawNSN.uintValue
        let animationCurve = UIViewAnimationOptions(rawValue: animationCurveRaw)
        
        if endFrame.origin.y >= UIScreen.main.bounds.size.height {
            bottomConstraint.constant = 0.0
        } else {
            bottomConstraint.constant = endFrame.size.height
        }
        
        UIView.animate(
            withDuration: duration,
            delay: TimeInterval(0),
            options: animationCurve,
            animations: animate,
            completion: nil
        )
    }
}
