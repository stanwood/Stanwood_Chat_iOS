//
//  DialogueViewControllerTests.swift
//  DialogueTests
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import XCTest

@testable import Dialogue

class DialogueViewControllerTests: XCTestCase {
    func testLoading() {
        let viewController = DialogueViewController.loadFromStoryboard()
    }
}
