//
//  AsyncDelegate.swift
//  MobileCodingExercise
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import Foundation

protocol AsyncDelegate {
    func asyncUpdate(response: AsyncResponse)
}

enum AsyncResponse {
    case success
    case failure(description: String)
}
