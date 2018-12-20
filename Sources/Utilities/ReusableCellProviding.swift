//
//  ReusableCellProviding.swift
//  Demo
//
//  Created by Eugène Peschard on 20/12/2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

protocol ReusableCellProviding {
    func provideReusableCell<Cell>(for index: Int) -> Cell where Cell: UITableViewCell
}

extension UITableView: ReusableCellProviding {
    func provideReusableCell<Cell>(for index: Int) -> Cell where Cell: UITableViewCell {
        return dequeue(
            cellType: Cell.self,
            for: IndexPath(row: index, section: 0)
        )
    }
}
