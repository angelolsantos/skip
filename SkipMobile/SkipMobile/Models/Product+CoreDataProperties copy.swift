//
//  Product+CoreDataProperties.swift
//  
//
//  Created by Angelo Lara dos Santos on 17/03/2018.
//
//

import Foundation
import CoreData
import SwiftyJSON

extension Product {
    
    init(json: JSON) {
        
        let dateFormatter = DateFormatter()

        id = json["id"].int64Value
        descriptions = json["description"].stringValue
        name = json["name"].stringValue
        price =  json["price"].dou
        orderItem = OrderItem(json: json["orderItem"])
        store = Store(json: json["store"])
        
    }
    
    func toParameters() -> [String : AnyObject] {
        
        
        var parameters = ["id" : id,
                          "description" : descriptions,
                          "name" : name,
                          "price" : price,
                          "orderItem" : orderItem?.toParameters(),
                          "store" : store.toParameters]
        
        
        return parameters
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var descriptions: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var orderItem: OrderItem?
    @NSManaged public var store: Store?

}
