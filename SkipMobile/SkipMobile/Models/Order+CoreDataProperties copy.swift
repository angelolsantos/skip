//
//  Order+CoreDataProperties.swift
//  
//
//  Created by Angelo Lara dos Santos on 17/03/2018.
//
//

import Foundation
import CoreData
import SwiftyJSON


extension Order {

    init(json: JSON) {
        
        let dateFormatter = DateFormatter()
        
        
        id = json["id"].int64Value
        contact = json["contact"].stringValue
        date =  dateFormatter.date(fromSwapiString: json["date"])
        deliveryAddress = json["deliveryAddress"].stringValue
        lastUpdate =  dateFormatter.date(fromSwapiString: json["lastUpdate"])
        status =  json["status"].stringValue
        total = json["total"].doubleValue
        customer = Customer(json: json["customer"])
        
        for orderItemJson in json["orderItems"].arrayObject {
            
            let orderItem = OrderItem(json: orderItemJson)
            
            orderItems?.adding(orderItem)
            
        }
        
        store = Store(json: json["store"])
        
    }
    
    func toParameters() -> [String : AnyObject] {
        
        let orderItemsArray = []
        
        for item in orderItemsArray {
            
            orderItemsArray.append(item.toParemeters())
            
        }
        
        var parameters = ["id" : id,
                          "contact" : nacontactme,
                          "date" : date,
                          "deliveryAddress" : deliveryAddress,
                          "status" : status,
                          "total" : total,
                          "customer" : customer,
                          "orderItems" : orderItemsArray,
                          "store" : store.toParameters()]
        
        
        
        return parameters
    }

    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var contact: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var deliveryAddress: String?
    @NSManaged public var id: Int64
    @NSManaged public var lastUpdate: NSDate?
    @NSManaged public var status: String?
    @NSManaged public var total: Double
    @NSManaged public var customer: Customer?
    @NSManaged public var orderItems: NSSet?
    @NSManaged public var store: Store?

}

// MARK: Generated accessors for orderItems
extension Order {

    @objc(addOrderItemsObject:)
    @NSManaged public func addToOrderItems(_ value: OrderItem)

    @objc(removeOrderItemsObject:)
    @NSManaged public func removeFromOrderItems(_ value: OrderItem)

    @objc(addOrderItems:)
    @NSManaged public func addToOrderItems(_ values: NSSet)

    @objc(removeOrderItems:)
    @NSManaged public func removeFromOrderItems(_ values: NSSet)

}
