//
//  UITableView+VerticallyOffsetable.swift
//  Dialogue
//
//  Created by Maciek on 22.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

extension UIScrollView: VerticallyOffsetable {
    var contentOffsetY: CGFloat {
        return contentOffset.y
    }
    
    var contentHeight: CGFloat {
        return contentSize.height
    }
    
    var height: CGFloat {
        return frame.size.height
    }
}

