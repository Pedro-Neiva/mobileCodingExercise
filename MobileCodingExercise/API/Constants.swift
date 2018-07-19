//
//  Constants.swift
//  MobileCodingExercise
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "https://webservices.vividseats.com/rest/mobile/v1"
    }
    
    struct APIParameterKey {
        static let startDate = "startDate"
        static let endDate = "endDate"
        static let includeSuggested = "includeSuggested"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
