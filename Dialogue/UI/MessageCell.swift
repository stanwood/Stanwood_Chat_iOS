//
//  MessageCell.swift
//  Dialogue
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
        
        adjust(for: viewModel.sender)
        adjust(with: viewModel.ordinalType)
    }
    
    private func adjust(for sender: MessageCellViewModel.Sender) {
        switch sender {
        case .app:
            textView.backgroundColor = UIColor.red
            alignment = .left
        case .user:
            textView.backgroundColor = UIColor.blue
            alignment = .right
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
}
