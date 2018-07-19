//
//  APIClientTests.swift
//  MobileCodingExerciseTests
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import MobileCodingExercise

class APIClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func testEventsFromStub() {
        let exp = expectation(description: "Get events from stub")
        
        let date = Date()
        stubRequestFor(path: APIRouter.discoverEvents(startDate: date, endDate: date).path, jsonFile: "EventList.json")
        
        APIClient.events(startDate: date, endDate: date) { result in
            switch result {
            case .success(let events):
                XCTAssertEqual(events.count, 20, "Load from stub doesn't have 20 events")
                XCTAssertEqual(events[0].targetId, 107)
                XCTAssertEqual(events[1].targetId, 759)
                XCTAssertEqual(events[2].targetId, 481)
                XCTAssertEqual(events[3].targetId, 358)
                XCTAssertEqual(events[4].targetId, 807)
                XCTAssertEqual(events[5].targetId, 50)
                XCTAssertEqual(events[6].targetId, 2422719)
                XCTAssertEqual(events[7].targetId, 2522999)
                XCTAssertEqual(events[8].targetId, 2413055)
                XCTAssertEqual(events[9].targetId, 162)
                XCTAssertEqual(events[10].targetId, 607)
                XCTAssertEqual(events[11].targetId, 771)
                XCTAssertEqual(events[12].targetId, 428)
                XCTAssertEqual(events[13].targetId, 2590991)
                XCTAssertEqual(events[14].targetId, 2650076)
                XCTAssertEqual(events[15].targetId, 7461)
                XCTAssertEqual(events[16].targetId, 2602117)
                XCTAssertEqual(events[17].targetId, 473)
                XCTAssertEqual(events[18].targetId, 2595646)
                XCTAssertEqual(events[19].targetId, 2499716)
            case .failure:
                XCTFail("Error loading events from stub")
            }
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testEventsFromWeb() {
        let exp = expectation(description: "Get events from web")
        
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
        
        APIClient.events(startDate: startDate, endDate: endDate) { result in
            switch result {
            case .success(let events):
                XCTAssertGreaterThan(events.count, 0, "Service doesn't returned data")
            case .failure:
                XCTFail("Error loading events from API")
            }
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testImageFromStub() {
        let exp = expectation(description: "Get image from file")
        
        let url = "https://a.vsstatic.com/mobile/app/mlb/boston-red-sox.jpg"
        
        stubRequestFor(path: "/app/mlb/boston-red-sox.jpg", jsonFile: "boston-red-sox.jpg")
        
        APIClient.dataFrom(url: url) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 97062, "Error getting local image")
            case .failure:
                XCTFail("Unable to get data from local image")
            }
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testImageFromWeb() {
        let exp = expectation(description: "Get image from web")
        
        let url = "https://a.vsstatic.com/mobile/app/mlb/boston-red-sox.jpg"
        
        APIClient.dataFrom(url: url) { result in
            switch result {
            case .success(let data):
                XCTAssertGreaterThan(data.count, 100, "Error getting web image")
            case .failure:
                XCTFail("Unable to get data from Web")
            }
            exp.fulfill()
        }
        
        waitForIt()
    }
}
