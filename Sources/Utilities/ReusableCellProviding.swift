//
//  ReusableCellProviding.swift
//  Chat
//
//  Created by Maciek on 26.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import UIKit

protocol ReusableCellProviding {
    func provideReusableCell(
        withIdentifier identifier: String,
        for index: Int
        ) -> UITableViewCell
}

extension UITableView: ReusableCellProviding {
    func provideReusableCell(
        withIdentifier identifier: String,
        for index: Int
        ) -> UITableViewCell {
        
        return dequeueReusableCell(
            withIdentifier: identifier,
            for: IndexPath(row: index, section: 0)
        )
    }
}
