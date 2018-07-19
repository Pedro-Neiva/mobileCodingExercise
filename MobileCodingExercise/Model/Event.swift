//
//  Event.swift
//  MobileCodingExercise
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import Foundation

struct Event: Codable {
    //MARK: Variables
    let top: String
    let middle: String
    let bottom: String
    let eventCount: Int
    let imageURL: String
    let targetId: Int
    let targetType: String
    let entityId: Int
    let entityType: String
    let startDate: Double
    let rank: Int
    
    //MARK: - Codable codingKeys
    enum CodingKeys: String, CodingKey {
        case top = "topLabel"
        case middle = "middleLabel"
        case bottom = "bottomLabel"
        case eventCount
        case imageURL = "image"
        case targetId
        case targetType
        case entityId
        case entityType
        case startDate
        case rank
    }
}
