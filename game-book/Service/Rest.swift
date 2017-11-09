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


protocol JSONValidation {
    static func JSON(with data: Data?) throws -> JSONObject
}

class Rest {
    
    static let path = URL.baseURL
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
    
    
    private static func handle(_ response: Alamofire.DataResponse<Data>, completion: @escaping (JSONResult) -> Void) {
        
        switch response.result {
        case .success(let value):
            
            do {
                let json = try JSON(with: value)
                completion(.success(json))
            } catch {
                completion(.failure(NSError()))
            }
            
        case .failure(let error):
            if let urlError = error as? URLError {
                completion(.failure(NSError()))
            } else if let afError = error as? AFError, let code = afError.responseCode {
                completion(.failure(NSError()))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
    static func dataRequest(_ url: String, method: Alamofire.HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, completion: @escaping (JSONResult) -> Void) {
        
        
        var completeHeader: Parameters = [:]
        if let headers = headers {
            for (key, value) in headers {
                completeHeader[key] = value
            }
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        alamofireManager.request("\(path)\(url)", method: method, parameters: parameters, encoding: encoding).validate(statusCode: 200..<300).responseData { (response) in
            handle(response, completion: completion)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    static func get(_ url: String, completion: @escaping (JSONResult) -> Void) {
        
    }
    static func getList(_ url: String, completion: @escaping (Result<[JSONObject]>) -> Void) {
        
    }
    
    // MARK: - JSON Validation
}

extension Rest : JSONValidation {
    static func JSON(with data: Data?) throws -> JSONObject {
        guard let responseData = data
            else { throw NSError() }
        
        // Convert JSON data to Swift JSON Object
        let responseJson = try JSONSerialization.jsonObject(with: responseData, options: [.allowFragments])
        guard let jsonObject = responseJson as? JSONObject
            else { throw NSError() }
        
        return jsonObject
    }
}

