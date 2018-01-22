//
//  OrdinalTypeTests.swift
//  DialogueTests
//
//  Created by Maciek on 19.01.2018.
//  Copyright © 2018 Stanwood. All rights reserved.
//

import XCTest

@testable import Dialogue

extension Message {
    static var receivedDummy: Message {
        return .received("")
    }
    
    static var repliedDummy: Message {
        return .replied("")
    }
}

class OrdinalTypeTests: XCTestCase {
    func testEmptyMessagesReturnsNil() {
        let messages: [Message] = []
        
        let ordinalType = OrdinalTypeRecognizer(for: messages).ordinalTypeForMesage(at: 0)
        
        XCTAssert(ordinalType == nil)
    }
    
    func testSingleMessageReturnsStandaloneAt0() {
        let messages: [Message] = [Message.receivedDummy]

        let ordinalType = OrdinalTypeRecognizer(for: messages).ordinalTypeForMesage(at: 0)

        XCTAssert(ordinalType == .standalone)
    }

    func testSingleMessageReturnsNilAt1() {
        let messages: [Message] = [Message.receivedDummy]

        let ordinalType = OrdinalTypeRecognizer(for: messages).ordinalTypeForMesage(at: 1)

        XCTAssert(ordinalType == nil)
    }

    func testTwoMessagesOfTheSameTypeReturnsFirstAt0() {
        let messages: [Message] = [
            Message.receivedDummy,
            Message.receivedDummy
        ]

        let ordinalType = OrdinalTypeRecognizer(for: messages).ordinalTypeForMesage(at: 0)

        XCTAssert(ordinalType == .firstInTheSerie)
    }

    func testTwoMessagesOfTheSameTypeReturnsLastAt1() {
        let messages: [Message] = [
            Message.receivedDummy,
            Message.receivedDummy
        ]

        let ordinalType = OrdinalTypeRecognizer(for: messages).ordinalTypeForMesage(at: 1)

        XCTAssert(ordinalType == .lastInTheSerie)
    }

    func testTwoMessagesOfDifferentTypesReturnsStandalone() {
        let messages: [Message] = [
            Message.receivedDummy,
            Message.repliedDummy
        ]

        let ordinalType0 = OrdinalTypeRecognizer(for: messages).ordinalTypeForMesage(at: 0)
        let ordinalType1 = OrdinalTypeRecognizer(for: messages).ordinalTypeForMesage(at: 1)

        XCTAssert(ordinalType0 == .standalone)
        XCTAssert(ordinalType1 == .standalone)
    }
    
    func testThreeMessagesOfTheSameTypeReturnsMiddleAt1() {
        let messages: [Message] = [
            Message.receivedDummy,
            Message.receivedDummy,
            Message.receivedDummy
        ]

        let ordinalType = OrdinalTypeRecognizer(for: messages).ordinalTypeForMesage(at: 1)

        XCTAssert(ordinalType == .middleInTheSerie)
    }
    
    func testThreeAlteringMessagesReturnsMiddleAt1() {
        let messages: [Message] = [
            Message.receivedDummy,
            Message.repliedDummy,
            Message.receivedDummy,
        ]
        
        let ordinalType = OrdinalTypeRecognizer(for: messages).ordinalTypeForMesage(at: 1)
        
        XCTAssert(ordinalType == .standalone)
    }
    
    func testThreeMessages1vs2ReturnsFirstAt1() {
        let messages: [Message] = [
            Message.receivedDummy,
            Message.repliedDummy,
            Message.repliedDummy,
            ]
        
        let ordinalType = OrdinalTypeRecognizer(for: messages).ordinalTypeForMesage(at: 1)
        
        XCTAssert(ordinalType == .firstInTheSerie)
    }
    
    func testThreeMessages2vs1ReturnsLastAt2() {
        let messages: [Message] = [
            Message.receivedDummy,
            Message.receivedDummy,
            Message.repliedDummy,
            ]
        
        let ordinalType = OrdinalTypeRecognizer(for: messages).ordinalTypeForMesage(at: 1)
        
        XCTAssert(ordinalType == .lastInTheSerie)
    }
}
