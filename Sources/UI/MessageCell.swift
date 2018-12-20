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
    enum Alignment {
        case left
        case right
    }
    
    enum OrdinalType {
        case standalone
        case firstInTheSerie
        case middleInTheSerie
        case lastInTheSerie
    }
    
    let textContent: TextContent
    let alignment: Alignment
    let ordinalType: OrdinalType
    let textColor: UIColor
    let backgroundColor: UIColor
    
    init(
        textContent: TextContent,
        alignment: Alignment,
        ordinalType: OrdinalType,
        textColor: UIColor,
        backgroundColor: UIColor
        ) {
        
        self.textContent = textContent
        self.alignment = alignment
        self.ordinalType = ordinalType
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}

class MessageCell: UITableViewCell {
    @IBOutlet private weak var textView: BubbleTextView!
    
    @IBOutlet private var leftAlignedLayoutConstraints: [NSLayoutConstraint]!
    @IBOutlet private var rightAlignedLayoutConstraints: [NSLayoutConstraint]!
    
    private var alignment: MessageCellViewModel.Alignment?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        alignment.map {
            switch $0 {
            case .left:
                alignLeft()
            case .right:
                alignRight()
            }
        }
    }
    
    override func prepareForReuse() {
        textView.text = nil
        textView.attributedText = nil
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    private func alignLeft() {
        contentView.removeConstraints(rightAlignedLayoutConstraints)
        contentView.addConstraints(leftAlignedLayoutConstraints)
    }
    
    private func alignRight() {
        contentView.removeConstraints(leftAlignedLayoutConstraints)
        contentView.addConstraints(rightAlignedLayoutConstraints)
    }
    
    private func leftAlignedRoundedCorners(
        for ordinalType: MessageCellViewModel.OrdinalType
        ) -> UIRectCorner {
        
        switch ordinalType {
        case .standalone:
            return .allCorners

        case .firstInTheSerie:
            return [
                .topLeft,
                .topRight,
                .bottomRight
            ]
            
        case .middleInTheSerie:
            return [
                .topRight,
                .bottomRight
            ]
            
        case .lastInTheSerie:
            return [
                .topRight,
                .bottomLeft,
                .bottomRight
            ]
        }
    }
    
    private func rightAlignedRoundedCorners(
        for ordinalType: MessageCellViewModel.OrdinalType
        ) -> UIRectCorner {
        
        switch ordinalType {
        case .standalone:
            return .allCorners

        case .firstInTheSerie:
            return [
                .topLeft,
                .topRight,
                .bottomLeft
            ]
            
        case .middleInTheSerie:
            return [
                .topLeft,
                .bottomLeft
            ]

        case .lastInTheSerie:
            return [
                .topLeft,
                .bottomLeft,
                .bottomRight
            ]
        }
    }
}

extension MessageCell {
    func prepare(with viewModel: MessageCellViewModel) {
        switch viewModel.textContent {
        case let .string(text):
            textView.text = text
        case let .attributedString(attributedText):
            textView.attributedText = attributedText
        }
        
        textView.textColor = viewModel.textColor
        textView.tintColor = viewModel.textColor
        textView.backgroundColor = viewModel.backgroundColor
        
        let ordinalType = viewModel.ordinalType
        alignment = viewModel.alignment
        
        alignment.map {
            switch $0 {
            case .left:
                textView.roundedCorners = leftAlignedRoundedCorners(for: ordinalType)
            case .right:
                textView.roundedCorners = rightAlignedRoundedCorners(for: ordinalType)
            }
        }
        
        contentView.setNeedsLayout()
        textView.setNeedsLayout()
    }
}
