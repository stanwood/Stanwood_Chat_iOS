//
//  MessageCell.swift
//  Dialogue
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

struct MessageCellViewModel {
    let text: String
    
    fileprivate init() {
        text = ""
    }
    
    init(text: String) {
        
        self.text = text
    }
}

class MessageCell: UITableViewCell {
    @IBOutlet private weak var textView: UITextView!
    
    override func prepareForReuse() {
        prepare(with: MessageCellViewModel())
    }
    
    func prepare(with viewModel: MessageCellViewModel) {
        textView.text = viewModel.text
    }
}
