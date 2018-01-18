//
//  BubbleTextView.swift
//  Dialogue
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

@IBDesignable
class BubbleTextView: UITextView {
    override func awakeFromNib() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
