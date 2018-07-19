//
//  XCTestCase+Extension.swift
//  MobileCodingExerciseTests
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import XCTest
import OHHTTPStubs

extension XCTestCase {
    
    func stubRequestFor(path:String, jsonFile:String) {
        stub(condition: pathEndsWith(path)) { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile(jsonFile, type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
    }
    
    func waitForIt(time: Double = 5) {
        
        waitForExpectations(timeout: time) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
}
