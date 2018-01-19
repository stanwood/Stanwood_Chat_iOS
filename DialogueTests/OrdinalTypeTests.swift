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
        
        let ordinalType = OrdinalRecognizer(for: messages).ordinalTypeForMesage(at: 0)
        
        XCTAssert(ordinalType == nil)
    }
    
    func testSingleMessageReturnsStandaloneAt0() {
        let messages: [Message] = [Message.receivedDummy]

        let ordinalType = OrdinalRecognizer(for: messages).ordinalTypeForMesage(at: 0)

        XCTAssert(ordinalType == .standalone)
    }

    func testSingleMessageReturnsNilAt1() {
        let messages: [Message] = [Message.receivedDummy]

        let ordinalType = OrdinalRecognizer(for: messages).ordinalTypeForMesage(at: 1)

        XCTAssert(ordinalType == nil)
    }
    
    func testTwoMessagesOfTheSameTypeReturnsFirstAt0() {
        let messages: [Message] = [
            Message.receivedDummy,
            Message.receivedDummy
        ]
        
        let ordinalType = OrdinalRecognizer(for: messages).ordinalTypeForMesage(at: 0)
        
        XCTAssert(ordinalType == .firstInTheSerie)
    }
}
