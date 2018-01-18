//
//  ChatViewControllerTests.swift
//  ChatTests
//
//  Created by Maciek on 18.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import XCTest

@testable import Chat

class ChatViewControllerTests: XCTestCase {
    func testLoading() {
        let viewController = ChatViewController.loadFromStoryboard()
    }
}
