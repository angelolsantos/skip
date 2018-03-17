//
//  OrderItem+CoreDataProperties.swift
//  
//
//  Created by Angelo Lara dos Santos on 17/03/2018.
//
//

import Foundation
import CoreData
import SwiftyJSON

extension OrderItem {
    
    convenience init(json: JSON) {
        
        let dateFormatter = DateFormatter()

        id = json["id"].int64Value
        price = json["price"].doubleValue
        quantity = json["quantity"].int64Value
        total = json["total"].doubleValue
        order = Order(json: json["order"])
        product = Product(json: json["product"])
        
    }
    
    func toParameters() -> [String : AnyObject] {
        
        var parameters = ["id" : id,
                          "price" : price,
                          "quantity" : quantity,
                          "total" : total,
                          "order" : order?.toParameters(),
                          "product" : product?.toParameters()]
        
        
        
        return parameters
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderItem> {
        return NSFetchRequest<OrderItem>(entityName: "OrderItem")
    }

    @NSManaged public var id: Int64
    @NSManaged public var price: Double
    @NSManaged public var quantity: Int64
    @NSManaged public var total: Double
    @NSManaged public var order: Order?
    @NSManaged public var product: Product?

}
