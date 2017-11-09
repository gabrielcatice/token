//
//  Data+JSON.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

public protocol JSONValue { }
public typealias JSONSwiftObject = [String: JSONValue] // Used when creating JSON from Swift model
public typealias JSONObject = [String: Any]            // Generic usage
public typealias JSONArray = [JSONObject]

protocol JSONRoot { }
extension String: JSONValue { }
extension Int: JSONValue { }
extension Double: JSONValue { }
extension Bool: JSONValue { }
extension Optional: JSONValue { typealias Wrapped = JSONValue }
extension Array: JSONValue, JSONRoot { typealias Element = JSONValue }
extension Dictionary: JSONValue, JSONRoot { typealias Key = String; typealias Value = JSONValue }

protocol JSONValidation {
    func jsonObject() throws -> JSONObject
}

extension Data: JSONValidation {
    public func jsonObject() throws -> JSONObject {
        
        // Convert JSON data to Swift JSON Object
        let responseJson = try JSONSerialization.jsonObject(with: self, options: [])
        guard let jsonObject = responseJson as? JSONObject
            else { throw NSError()}
        
        return jsonObject
    }
    
    public func jsonArray() throws -> JSONArray {
        // Convert JSON data to Swift JSON Object
        let responseJson = try JSONSerialization.jsonObject(with: self, options: [])
        guard let jsonObject = responseJson as? JSONArray
            else { throw NSError() }
        
        return jsonObject
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    func jsonString() throws -> String {
        let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
        if let stringRepresentation = String(data: jsonData, encoding: .utf8) {
            return stringRepresentation
        }
        
        throw NSError()
    }
}
