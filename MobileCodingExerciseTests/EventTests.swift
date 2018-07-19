//
//  EventTests.swift
//  MobileCodingExerciseTests
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import MobileCodingExercise

class EventTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCodable() {
        let path = OHPathForFile("Event.json", type(of: self))!
        
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let event = try JSONDecoder().decode(Event.self, from: data)
            
            
            XCTAssertEqual(event.top, "Boston Red Sox")
            XCTAssertEqual(event.middle, "Fenway Park - Boston, MA")
            XCTAssertEqual(event.bottom, "Sun, Jul 15 - Sun, Aug 05")
            XCTAssertEqual(event.eventCount, 11)
            XCTAssertEqual(event.imageURL, "https://a.vsstatic.com/mobile/app/mlb/boston-red-sox.jpg")
            XCTAssertEqual(event.targetId, 107)
            XCTAssertEqual(event.targetType, "PERFORMER")
            XCTAssertEqual(event.entityId, 107)
            XCTAssertEqual(event.entityType, "PERFORMER")
            XCTAssertEqual(event.startDate, 1531677900000)
            XCTAssertEqual(event.rank, 320)
        } catch {
            XCTFail("Error loading movie from stub")
        }
    }
}
