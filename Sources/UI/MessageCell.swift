//
//  MessageCell.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2018 Stanwood GmbH (www.stanwood.io)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

struct MessageCellViewModel {
    enum Sender {
        case user
        case app
    }
    
    enum OrdinalType {
        case standalone
        case firstInTheSerie
        case middleInTheSerie
        case lastInTheSerie
    }
    
    let text: String
    let sender: Sender
    let ordinalType: OrdinalType
    
    fileprivate init() {
        text = ""
        sender = .app
        ordinalType = .firstInTheSerie
    }
    
    init(
        text: String,
        sender: Sender,
        ordinalType: OrdinalType
        ) {
        
        self.text = text
        self.sender = sender
        self.ordinalType = ordinalType
    }
}

class MessageCell: UITableViewCell {
    enum Alignment {
        case left
        case right
    }
    
    @IBOutlet private weak var textView: UITextView!
    
    @IBOutlet private var leftAlignedLayoutConstraints: [NSLayoutConstraint]!
    @IBOutlet private var rightAlignedLayoutConstraints: [NSLayoutConstraint]!
    
    private var alignment: Alignment!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch alignment! {
        case .left:
            alignLeft()
        case .right:
            alignRight()
        }
    }
    
    override func prepareForReuse() {
        prepare(with: MessageCellViewModel())
    }
    
    func prepare(with viewModel: MessageCellViewModel) {
        textView.text = viewModel.text
        
        adjust(for: viewModel.sender, of: viewModel.ordinalType)
    }
    
    private func adjust(
        for sender: MessageCellViewModel.Sender,
        of ordinalType: MessageCellViewModel.OrdinalType
        ) {
        
        switch sender {
        case .app:
            textView.backgroundColor = UIColor.red
            alignment = .left
            applyLeftAlignedStyle(for: ordinalType)
        case .user:
            textView.backgroundColor = UIColor.blue
            alignment = .right
            applyRightAlignedStyle(ordinalType)
        }
    }
    
    private func alignLeft() {
        contentView.removeConstraints(rightAlignedLayoutConstraints)
        contentView.addConstraints(leftAlignedLayoutConstraints)
    }
    
    private func alignRight() {
        contentView.removeConstraints(leftAlignedLayoutConstraints)
        contentView.addConstraints(rightAlignedLayoutConstraints)
    }
    
    private func applyLeftAlignedStyle(for ordinalType: MessageCellViewModel.OrdinalType) {
        switch ordinalType {
        case .standalone:
            textView.layer.maskedCorners = [
                .layerMaxXMaxYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMinXMinYCorner
            ]
            
        case .firstInTheSerie:
            textView.layer.maskedCorners = [
                .layerMaxXMaxYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMinYCorner
            ]
            
        case .middleInTheSerie:
            textView.layer.maskedCorners = [
                .layerMaxXMaxYCorner,
                .layerMaxXMinYCorner
            ]
            
        case .lastInTheSerie:
            textView.layer.maskedCorners = [
                .layerMaxXMaxYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner
            ]
        }
    }
    
    private func applyRightAlignedStyle(_ ordinalType: MessageCellViewModel.OrdinalType) {
        switch ordinalType {
        case .standalone:
            textView.layer.maskedCorners = [
                .layerMaxXMaxYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMinXMinYCorner
            ]
            
        case .firstInTheSerie:
            textView.layer.maskedCorners = [
                .layerMinXMaxYCorner,
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner
            ]
            
        case .middleInTheSerie:
            textView.layer.maskedCorners = [
                .layerMinXMaxYCorner,
                .layerMinXMinYCorner
            ]
            
        case .lastInTheSerie:
            textView.layer.maskedCorners = [
                .layerMinXMaxYCorner,
                .layerMinXMinYCorner,
                .layerMaxXMaxYCorner
            ]
        }
    }
}
