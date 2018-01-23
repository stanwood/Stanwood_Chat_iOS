//
//  KeepingAtTheBottomOffsetCalculatorTests.swift
//  ChatTests
//
//  Created by Maciek on 22.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import XCTest

@testable import Chat

struct VerticallyOffsetableContainer: VerticallyOffsetable {
    let contentOffsetY: CGFloat
    let contentHeight: CGFloat
    
    let height: CGFloat
}

class KeepingAtTheBottomOffsetCalculatorTests: XCTestCase {
    func testContentEmptyReturnsOriginalContentOffset() {
        let container = VerticallyOffsetableContainer(
            contentOffsetY: 0,
            contentHeight: 0,
            height: 0
        )
        
        let offset = KeepingAtTheBottomOffsetCalculator(for: container).calculate()
        
        XCTAssert(offset == CGPoint(x: 0, y: 0))
    }
    
    func testContentUnderBottomEdgeNoOffsetReturnsOriginalContentOffset() {
        let container = VerticallyOffsetableContainer(
            contentOffsetY: 20,
            contentHeight: 50,
            height: 100
        )
        
        let offset = KeepingAtTheBottomOffsetCalculator(for: container).calculate()
        
        XCTAssert(offset == CGPoint(x: 0, y: 20))
    }
    
    func testContentBiggerThanHeightUnderBottomEdgeWithOffsetReturnsOriginalContentOffset() {
        let container = VerticallyOffsetableContainer(
            contentOffsetY: 100,
            contentHeight: 150,
            height: 100
        )
        
        let offset = KeepingAtTheBottomOffsetCalculator(for: container).calculate()
        
        XCTAssert(offset == CGPoint(x: 0, y: 100))
    }
    
    func testContentBiggerThanHeightOverBottomEdgeWithNoOffsetGivesDifference() {
        let container = VerticallyOffsetableContainer(
            contentOffsetY: 0,
            contentHeight: 200,
            height: 100
        )
        
        let offset = KeepingAtTheBottomOffsetCalculator(for: container).calculate()
        
        XCTAssert(offset == CGPoint(x: 0, y: 100))
    }
}
