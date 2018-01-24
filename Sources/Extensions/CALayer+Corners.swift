//
//  CALayer+Corners.swift
//  Demo
//
//  Created by Maciek on 23.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

extension CALayer {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )

        let mask = CAShapeLayer()
        mask.path = path.cgPath

        self.mask = mask
    }
}
