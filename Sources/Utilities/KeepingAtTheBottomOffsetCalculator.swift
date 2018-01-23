//
//  KeepingAtTheBottomOffsetCalculator.swift
//  Chat
//
//  Created by Maciek on 19.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

protocol VerticallyOffsetable {
    var contentOffsetY: CGFloat { get }
    var contentHeight: CGFloat { get }
    
    var height: CGFloat { get }
}

class KeepingAtTheBottomOffsetCalculator {
    private var container: VerticallyOffsetable
    
    init(for container: VerticallyOffsetable) {
        self.container = container
    }
    
    func calculate() -> CGPoint {
        let contentBottomEdge = -container.contentOffsetY + container.contentHeight
        if contentBottomEdge > container.height {
            return CGPoint(
                x: 0,
                y: container.contentHeight - container.height
            )
        }
        else {
            return CGPoint(
                x: 0,
                y: container.contentOffsetY
            )
        }
    }
}
