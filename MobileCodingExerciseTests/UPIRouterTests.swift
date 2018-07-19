//
//  UPIRouterTests.swift
//  MobileCodingExerciseTests
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import XCTest
@testable import MobileCodingExercise

class UPIRouterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDiscoverEvents() {
        do {
            let calendar = Calendar(identifier: .gregorian)
            let components = DateComponents(year: 2018, month: 7, day: 15, hour: 0, minute: 0, second: 0)
            let date = calendar.date(from: components)!
            
            let urlRequest =  try APIRouter.discoverEvents(startDate: date, endDate: date).asURLRequest()
            
            XCTAssertEqual(urlRequest.url?.absoluteString, "https://webservices.vividseats.com/rest/mobile/v1/home/cards")
            XCTAssertEqual(urlRequest.httpMethod, "POST")
            XCTAssertEqual(urlRequest.value(forHTTPHeaderField: HTTPHeaderField.contentType.rawValue), "application/json")
            
            let json = try JSONSerialization.jsonObject(with: urlRequest.httpBody!, options: .mutableContainers)
            
            guard let data = json as? [String: String] else {
                XCTFail("HTTP body is not a Json")
                return
            }
            
            XCTAssertEqual(data.count, 3)
            XCTAssertEqual(data[K.APIParameterKey.startDate], "2018-07-15")
            XCTAssertEqual(data[K.APIParameterKey.includeSuggested], "true")
            XCTAssertEqual(data[K.APIParameterKey.endDate], "2018-07-15")
        }
        catch {
            XCTFail("Error loading events from stub")
        }
    }
}
