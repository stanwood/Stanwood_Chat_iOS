//
//  BubbleTextView.swift
//  Chat
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

@IBDesignable
class BubbleTextView: UITextView {
    var roundedCorners: UIRectCorner = .allCorners
    
    override func awakeFromNib() {
        layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.roundCorners(corners: roundedCorners, radius: 10)
    }
}
