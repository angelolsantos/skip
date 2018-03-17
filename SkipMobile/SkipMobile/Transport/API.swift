//
//  API.swift
//  SkipMobile
//
//  Created by Angelo Lara dos Santos on 17/03/2018.
//  Copyright © 2018 angelo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


final class Api {
    
    
    // MARK: - Private Properties
    private let managerAPI: APIManagerProtocol
    
    // MARK: - Designated Initializer
    init(manager: APIManagerProtocol = Configuration.manager) {
        self.managerAPI = manager
    }
    
    // MARK: - Public Methods
    func getCousinList(completion: APIResult<Cousine> -> [Any] ) {
        managerAPI.apiRequest(.GetCousinList).apiResponse { response in
            switch response.result {
            case .Success(let json):
                var cousineList = try? JSONSerialization.jsonObject(with: json, options: .allowFragments)
                completion(APIResult{return cousineList})
            case .Failure(let error):
                completion(APIResult{throw error})
            }
        }
    }
    
    func getCousineByDescription(description: String, completion: APIResult<Cousine> -> [Any]) {
        managerAPI.apiRequest(.GetCousineByDescription(description: description), parameters:["searchText" : description]).apiResponse { response in
            switch response.result {
            case .Success(let json):
                var  cousineList = try? JSONSerialization.jsonObject(with: json, options: .allowFragments)
                completion(APIResult{return cousineList})
            case .Failure(let error):
                completion(APIResult{throw error})
            }
        }
    }
    
    
    func getProductInfo(productId: Int, completion: ApiResult<User> -> Void) {
        manager.apiRequest(.GetProductInfo(productId: productId)).apiResponse { response in
            switch response.result {
            case .Success(let json):
                let product = Product(json: json["data"])
                completion(ApiResult{ return product })
            case .Failure(let error):
                completion(ApiResult{ throw error })
            }
        }
    }
    
    func updateCustomerInfo(customerId: Customer, completion: ApiResult<User> -> Void) {
        manager.apiRequest(.UpdateCustomerInfo(customerId: customerId.userId), parameters: customer.toParameters()).apiResponse { response in
            switch response.result {
            case .Success(let json):
                let customer = Customer(json: json["data"])
                completion(ApiResult{ return customer })
            case .Failure(let error):
                completion(ApiResult{ throw error })
            }
        }
    }
}

struct Configuration {
    static var manager: ApiManagerProtocol {
        return isUITesting() ? SeededManager() : Manager.sharedInstance
    }
    
    private static func isUITesting() -> Bool {
        return NSProcessInfo.processInfo().arguments.contains("UI Testing")
    }
}
