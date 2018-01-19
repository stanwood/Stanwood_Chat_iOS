//
//  AtTheBottomKeeper.swift
//  Dialogue
//
//  Created by Maciek on 19.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

class AtTheBottomKeeper {
    private weak var tableView: UITableView?
    
    private var currentBottomOffset: CGFloat?
    private var isActive: Bool = false
    
    init(for tableView: UITableView) {
        self.tableView = tableView
    }
    
    func activate(withBottomOffset bottomOffset: CGFloat) {
        currentBottomOffset = bottomOffset
        isActive = true
    }
    
    func deactivate() {
        isActive = false
    }
    
    func update(withBottomOffset bottomOffset: CGFloat) {
        guard isActive else { return }
        guard let tableView = tableView else { return }
        
        let heightOfVisibleContent = tableView.contentSize.height - tableView.contentOffset.y
        if heightOfVisibleContent > tableView.frame.size.height {
            if let currentBottomOffset = currentBottomOffset {
                let contentOffset = tableView.contentOffset
                tableView.contentOffset = contentOffset
                    .applying(
                        CGAffineTransform(
                            translationX: 0,
                            y: bottomOffset - currentBottomOffset
                        )
                )
            }
        }
        
        currentBottomOffset = bottomOffset
    }
}
