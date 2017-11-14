//
//  Rest.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONObject = [String: Any]
typealias JSONResult = Result<JSONObject>

class Rest {
    
    static let path = URLs.baseURL
    //Configuration for requests
    enum Configuration: Double {
        case timeoutIntervalForRequest = 20.0
        case timeoutIntervalForResource = 21.0
    }
    
    static var configuration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Configuration.timeoutIntervalForRequest.rawValue // seconds
        configuration.timeoutIntervalForResource = Configuration.timeoutIntervalForResource.rawValue // seconds
        return configuration
    }
    
    
    static let alamofireManager = Alamofire.SessionManager(configuration: configuration)
    
    //handling the response. Supports simple objects or arrays in the json root
    private static func handle(_ response: Alamofire.DataResponse<Data>, completionObject: ((Result<JSONObject>) -> Void)? = nil, completionArray: ((Result<[JSONObject]>) -> Void)? = nil) {
        
        
        switch response.result {
            
        case .success(let value):
            if let json = try? jsonObject(with: value) {
                completionObject?(.success(json))
            } else {
                completionObject?(.failure(NSError()))
            }
            
            if let jsonArray = try? jsonArray(with: value) {
                completionArray?(.success(jsonArray))
            } else {
                
                completionArray?(.failure(NSError()))
            }
            
        case .failure( _):
            completionObject?(.failure(NSError()))
            completionArray?(.failure(NSError()))
        }
    }
    
    static func dataRequest(_ url: String, method: Alamofire.HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders? = nil, completionObject: ((Result<JSONObject>) -> Void)? = nil, completionArray: ((Result<[JSONObject]>) -> Void)? = nil) {
        
        var completeHeader: Parameters = [:]
        if let headers = headers {
            for (key, value) in headers {
                completeHeader[key] = value
            }
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        alamofireManager.request("\(path)\(url)", method: method, parameters: parameters, encoding: encoding).validate(statusCode: 200..<300).responseData { (response) in
            handle(response, completionObject: completionObject, completionArray: completionArray)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    //http methods implementation
    static func get(_ url: String, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping (Result<JSONObject>) -> Void) {
        dataRequest(url, method: .get, parameters: parameters, encoding: encoding, headers: headers, completionObject: completion)
        
        
    }
    static func getList(_ url: String, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping (Result<[JSONObject]>) -> Void) {
        dataRequest(url, method: .get, parameters: parameters, encoding: encoding, headers: headers, completionArray: completion)
        
    }
    
    //JSON Validation
}

extension Rest {
    static func jsonObject(with data: Data?) throws -> JSONObject {
        guard let responseData = data
            else { throw NSError() }
        
        // Convert JSON data to Swift JSON Object
        let responseJson = try JSONSerialization.jsonObject(with: responseData, options: [.allowFragments])
        guard let jsonObject = responseJson as? JSONObject
            else { throw NSError() }
        
        return jsonObject
    }
    
    static func jsonArray(with data: Data?) throws -> [JSONObject] {
        guard let responseData = data
            else { throw NSError() }
        
        // Convert JSON array data to Swift JSON Object
        let responseJson = try! JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments) as! JSONObject
        guard let jsonArray = responseJson["games"] as? [JSONObject]
            else { throw NSError() }
        return jsonArray
    }
}
