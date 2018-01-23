//
//  UIStackViewCustomizingLayout.swift
//  Chat
//
//  Created by Maciek on 19.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

@objc
protocol UIStackViewDelegate: class {
    func didLayoutSubViews()
}

@IBDesignable
class UIStackViewCustomizingLayout: UIStackView {
    @IBOutlet weak var delegate: UIStackViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        delegate?.didLayoutSubViews()
    }
}
