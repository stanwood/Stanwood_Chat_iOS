//
//  UITableView+Reusable.swift
//  ONAir
//
//  Created by Maciek on 17.10.2017.
//  Copyright © 2017 Stanwood. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeue<Cell>(
        cellType: Cell.Type,
        for indexPath: IndexPath
        ) -> Cell where Cell: UITableViewCell {
        
        let cell = dequeueReusableCell(
            withIdentifier: cellType.reuseIdentifier,
            for: indexPath
        )
        
        guard let castedCell = cell as? Cell else {
            fatalError("Cell \(cell) cannot be casted as \(cellType.reuseIdentifier)")
        }
        
        return castedCell
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing:self)
    }
}
