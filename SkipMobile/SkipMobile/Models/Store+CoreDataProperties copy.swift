//
//  Store+CoreDataProperties.swift
//  
//
//  Created by Angelo Lara dos Santos on 17/03/2018.
//
//

import Foundation
import CoreData
import SwiftyJSON


extension Store {
    
    init(json: JSON) {
        
        id = json["id"].int64Value
        name = json["name"].stringValue
        address = json["address"].stringValue
        cousine = Cousine(json: json["cousine"])
        
        for orderJson in json["orders"].arrayObject {
            
            let order = Order(json: orderJson)
            
            orders?.adding(order)
            
        }
        
    }
    
//    func toParameters() -> [String : AnyObject] {
//        var parameters = ["id" : id,
//                          "name" : name,
//                          "address" : address,
//                          "cousine"]
//        if let description = description {
//            parameters["description"] = description
//        }
//        
//        return parameters
//    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Store> {
        return NSFetchRequest<Store>(entityName: "Store")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var cousine: Cousine?
    @NSManaged public var orders: NSSet?
    @NSManaged public var product: NSSet?

}

// MARK: Generated accessors for orders
extension Store {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: Order)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: Order)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}
