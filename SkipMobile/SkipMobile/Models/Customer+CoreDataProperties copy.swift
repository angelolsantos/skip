//
//  Customer+CoreDataProperties.swift
//  
//
//  Created by Angelo Lara dos Santos on 17/03/2018.
//
//

import Foundation
import CoreData
import SwiftyJSON

extension Customer {
    
    init(json: JSON) {
        
        let dateFormatter = DateFormatter()
        
        id = json["id"].int64Value
        address = json["address"].stringValue
        creation = dateFormatter.date(fromSwapiString: json["creation"].stringValue)
        email = json["email"].stringValue
        name = json["name"].stringValue
        password = json["password"].stringValue
        
        for orderJson in json["orders"].arrayObject {
            
            let order = Order(json: orderJson)
            
            orders?.adding(order)
            
        }
        
    }
    
    func toParameters() -> [String : AnyObject] {
        
        let ordersArray = []
        
        for order in ordersArray {
            
            ordersArray.append(order.toParemeters())
            
        }
        
        var parameters = ["id" : id,
                          "address" : address,
                          "creation" : creation,
                          "email" : email,
                          "name" : name,
                          "password" : password,
                          "orders" : ordersArray]

        return parameters
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var address: String?
    @NSManaged public var creation: NSDate?
    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var order: NSSet?

}

// MARK: Generated accessors for order
extension Customer {

    @objc(addOrderObject:)
    @NSManaged public func addToOrder(_ value: Order)

    @objc(removeOrderObject:)
    @NSManaged public func removeFromOrder(_ value: Order)

    @objc(addOrder:)
    @NSManaged public func addToOrder(_ values: NSSet)

    @objc(removeOrder:)
    @NSManaged public func removeFromOrder(_ values: NSSet)

}
