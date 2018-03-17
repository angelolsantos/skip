//
//  APIProtocol.swift
//  SkipMobile
//
//  Created by Angelo Lara dos Santos on 17/03/2018.
//  Copyright © 2018 angelo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol APIManagerProtocol {
    func apiRequest(endpoint: EndPoint, parameters: [String : AnyObject]?, headers: [String : String]?) -> APIRequestProtocol
}

extension APIManagerProtocol {
    func apiRequest(endpoint: EndPoint) -> APIRequestProtocol {
        return apiRequest(endpoint: endpoint, parameters: nil, headers: nil)
    }
    
    func apiRequest(endpoint: EndPoint, parameters: [String : AnyObject]?) -> APIRequestProtocol {
        return apiRequest(endpoint: endpoint, parameters: parameters, headers: nil)
    }
}

protocol APIRequestProtocol {
    func apiResponse(completionHandler: (URLResponse) -> Void) -> Self
}

func += <K, V> ( left: [K : V], right: [K : V]) {
    var right = right
    var left = left
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

extension SessionManager: APIManagerProtocol {
    func apiRequest(endpoint: EndPoint, parameters: [String : AnyObject]? = nil, headers: [String : String]? = nil) -> APIRequestProtocol {
        // Insert your common headers here, for example, authorization token or accept.
        var commonHeaders = ["Accept" : "application/json"]
        if let headers = headers {
            commonHeaders += headers
        }
        
        return request(endpoint.method, endpoint.url, parameters: parameters, headers: commonHeaders)
    }
}

extension Request: APIRequestProtocol {
    static func apiResponseSerializer() -> DataResponseSerializer<JSON> {
        return DataResponseSerializer { _, _, data, error in
    
            guard let validData = data else {
                let reason = "Data could not be serialized. Input data was nil."
                return (NSError(domain: "angelo.SkipMobile", code: 1001, userInfo: [NSLocalizedDescriptionKey : reason]))
            }
            
            do {
                let json = try JSON(data: validData)
                // TODO: Should consider HTTP response as well.
                return sanitizeError(json)
            } catch let error as NSError {
                return .Failure(error)
            }
        }
    }
    
    static func sanitizeError(json: JSON) -> Result<JSON, NSError> {
        if json["error"].object == nil {
            return .Success(json)
        }
        
        let code = json["error"]["code"].intValue
        let message = json["error"]["message"].stringValue
        let error = NSError(domain: "angelo.SkipMobile", code: code, userInfo: [NSLocalizedDescriptionKey : message])
        return .Failure(error)
    }
    
    func apiResponse(completionHandler: Response<JSON, NSError> -> Void) -> Self {
        return response(responseSerializer: Request.apiResponseSerializer(), completionHandler: completionHandler)
    }
}
