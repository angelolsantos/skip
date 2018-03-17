//
//  APIEndPoint.swift
//  SkipMobile
//
//  Created by Angelo Lara dos Santos on 17/03/2018.
//  Copyright © 2018 angelo. All rights reserved.
//

import Foundation
import Alamofire

enum EndPoint{
    
    //Customer
    case CreateCustomer(customerId: Int)
    case AuthenticateCustomer(customerId: Int)
    
    //Cousine
    case GetCousineList()
    case GetCousineByDescription(description: String)
    case GetCousineStores(cousineId: Int)
    
    //Order
    case GetOrderInfo(orderId: Int)
    case PlaceOrder()
    case GetOrderByCustomer(customerId: Int)
    
    //Product
    case GetProductList()
    case GetProductByDescription(description: String)
    case GetProductinfo(productId: Int)
    
    //Store
    case GetStoreList()
    case GetStoreByDescription(description: String)
    case GetStoreInfo(storeId: Int)
    case GetStoreProducts(storeId: Int)
    
    
    var method: Alamofire.Method.Type {
        switch self {
        case .CreateCustomer:
            return .POST
        case .AuthenticateCustomer:
            return .POST
            
        case .GetCousineList:
            return .GET
        case .GetCousineByDescription:
            return .GET
        case .GetCousineStores:
            return .GET
            
        case .GetOrderInfo:
            return .GET
        case .PlaceOrder:
            return .POST
        case .GetOrderByCustomer:
            return .GET
            
        case .GetProductList:
            return .GET
        case .GetProductByDescription:
            return .GET
        case .GetProductinfo:
            return .GET
            
        case .GetStoreList:
            return .GET
        case .GetStoreByDescription:
            return .GET
        case .GetStoreInfo:
            return .GET
        case .GetStoreProducts:
            return .GET
        
        }
        
    }
    
    var url: NSURL {
        let baseUrl = NSURL.getBaseUrl()
        switch self {
        case .CreateCustomer():
            return baseUrl.URLByAppendingPathComponent("/api/v1/Customer/")
        case .AuthenticateCustomer(let customerId):
            return baseUrl.URLByAppendingPathComponent("/api/v1/Customer/Auth")
            
        case .GetCousineList(let cousineDescription):
            return baseUrl.URLByAppendingPathComponent("/api/v1/Cousine")
        case .GetCousineByDescription(let description):
            return baseUrl.URLByAppendingPathComponent("/api/v1/Cousine/search/\(description)")
        case .GetCousineStores(let cousineId):
            return baseUrl.URLByAppendingPathComponent("/api/v1/Cousine/\(description)/stores")
            
        case .GetOrderInfo(let orderId):
            return baseUrl.URLByAppendingPathComponent("/api/v1/Order/\(orderId)")
        case .PlaceOrder():
            return baseUrl.URLByAppendingPathComponent("/api/v1/Order")
        case .GetOrderByCustomer():
            return baseUrl.URLByAppendingPathComponent("/api/v1/Order/customer")
            
        case .GetProductList():
            return baseUrl.URLByAppendingPathComponent("/api/v1/Product")
        case .GetProductByDescription(let description):
            return baseUrl.URLByAppendingPathComponent("/api/v1/Product/search/\(description)")
        case .GetProductinfo(let productId):
            return baseUrl.URLByAppendingPathComponent("/api/v1/Product/\(productId)")
        
        }
    }
    
}

private extension NSURL {
    static func getBaseUrl() -> NSURL {
        guard let info = NSBundle.mainBundle().infoDictionary,
            let urlString = info["Base url"] as? String,
            let url = NSURL(string: urlString) else {
                fatalError("Cannot get base url from info.plist")
        }
        
        return url
    }
}
