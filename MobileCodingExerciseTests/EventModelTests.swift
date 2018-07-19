//
//  EventModelTests.swift
//  MobileCodingExerciseTests
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import MobileCodingExercise

class EventModelTests: XCTestCase, AsyncDelegate {
    
    private var expectation: XCTestExpectation!
    private var model: EventModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchEvents() {
        expectation = expectation(description: "Get events from stubs")
        
        let date = Date()
        stubRequestFor(path: APIRouter.discoverEvents(startDate: date, endDate: date).path, jsonFile: "EventList.json")
        
        model = EventModel()
        model.asyncDelegate = self
        
        waitForIt()
    }
    
    func asyncUpdate(response: AsyncResponse) {
        switch response {
        case .success:
            XCTAssertEqual(model.count, 20, "Couldn't load 20 events from stub")
        case .failure:
            XCTFail("Error loading events from stub")
        }
        expectation.fulfill()
    }
}
