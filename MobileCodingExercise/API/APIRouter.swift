//
//  APIRouter.swift
//  MobileCodingExercise
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import Foundation
import Alamofire

/// Enum that implements _URLRequestConvertible_, is used to request data from server.
///
/// - discoverEvents: Connect with /home/cards
enum APIRouter: URLRequestConvertible {
    
    case discoverEvents(startDate: Date, endDate: Date)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .discoverEvents:
            return .post
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .discoverEvents:
            return "/home/cards"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .discoverEvents(let startDate, let endDate):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            return [K.APIParameterKey.includeSuggested: "true", K.APIParameterKey.startDate: dateFormatter.string(from: startDate), K.APIParameterKey.endDate: dateFormatter.string(from: endDate)]
        }
    }
    
    // MARK: - URL Parameters
    private var urlParameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var urlStr = K.ProductionServer.baseURL.appending(path)
        
        // URL Parameters
        if let parameters = urlParameters {
            urlStr += parameters.reduce("?") { (result, tuple) in
                return "\(result)\(tuple.key)=\(tuple.value)&"
            }
        }
        
        let url = try urlStr.asURL()
        
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Body parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
