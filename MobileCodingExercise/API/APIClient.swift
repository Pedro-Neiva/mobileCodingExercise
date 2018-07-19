//
//  APIClient.swift
//  MobileCodingExercise
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import Foundation
import Alamofire

/// Service error.
///
/// - failedToParse: Used when is not possible parse the object.
enum ServiceError : Error {
    case failedToParse(String)
}

/// Class used to request data from API.
class APIClient {
    
    /// Request events from API
    ///
    /// - Parameters:
    ///   - startDate: Start date
    ///   - endDate: End date
    ///   - completion: Closure that has the result as parameter
    static func events(startDate: Date, endDate: Date, completion:@escaping (Result<[Event]>)->Void) {
        Alamofire.request(APIRouter.discoverEvents(startDate: startDate, endDate: endDate))
            .responseJSON() { response in
                guard response.result.isSuccess else { return }
                
                let data = response.value!
                
                var events = [Event]()
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let reqJSONStr = String(data: jsonData, encoding: .utf8)
                    let dataJS = reqJSONStr?.data(using: .utf8)
                    let jsonDecoder = JSONDecoder()
                    
                    events = try jsonDecoder.decode([Event].self, from: dataJS!)
                }
                catch {
                    let result = Result<[Event]>.failure(error)
                    completion(result)
                    return
                }
                let result = Result<[Event]>.success(events)
                completion(result)
        }
    }
    
    /// Load data from URL
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - completion: Closure that has the result of the request
    static func dataFrom(url: String, completion:@escaping (Result<Data>)->Void) {
        Alamofire.request(url)
            .responseData { dataResponse in
                guard let data = dataResponse.data else {
                    let result = Result<Data>.failure(ServiceError.failedToParse("\(url) do not have data"))
                    completion(result)
                    return
                }
                
                let result = Result<Data>.success(data)
                completion(result)
        }
    }
}
