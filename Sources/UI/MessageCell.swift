//
//  MessageCell.swift
//  Chat
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

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
    
    @IBOutlet private weak var textView: BubbleTextView!
    
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
        textView.text = nil
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
            textView.roundedCorners = leftAlignedRoundedCorners(for: ordinalType)
        case .user:
            textView.backgroundColor = UIColor.blue
            alignment = .right
            textView.roundedCorners = rightAlignedRoundedCorners(for: ordinalType)
        }
        
        textView.setNeedsLayout()
    }
    
    private func alignLeft() {
        contentView.removeConstraints(rightAlignedLayoutConstraints)
        contentView.addConstraints(leftAlignedLayoutConstraints)
    }
    
    private func alignRight() {
        contentView.removeConstraints(leftAlignedLayoutConstraints)
        contentView.addConstraints(rightAlignedLayoutConstraints)
    }
    
    private func leftAlignedRoundedCorners(for ordinalType: MessageCellViewModel.OrdinalType) -> UIRectCorner {
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
    
    private func rightAlignedRoundedCorners(for ordinalType: MessageCellViewModel.OrdinalType) -> UIRectCorner {
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
