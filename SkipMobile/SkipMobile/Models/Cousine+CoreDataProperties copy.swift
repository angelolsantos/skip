//
//  Cousine+CoreDataProperties.swift
//  
//
//  Created by Angelo Lara dos Santos on 17/03/2018.
//
//

import Foundation
import CoreData
import SwiftyJSON

extension Cousine {
    
    init(json: JSON) {
        
        let dateFormatter = DateFormatter()
        
        id = json["id"].int64Value
        name = json["name"].stringValue
        
        for storeJson in json["stores"].arrayObject {
            
            let store = Store(json: storeJson)
            
            stores?.adding(store)
            
        }

        
    }
    
    func toParameters(description: String) -> [String : AnyObject] {
        
        
        var parameters = ["searchText" : description]
        
        
        return parameters
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cousine> {
        return NSFetchRequest<Cousine>(entityName: "Cousine")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var stores: NSSet?

}

// MARK: Generated accessors for store
extension Cousine {

    @objc(addStoreObject:)
    @NSManaged public func addToStore(_ value: Store)

    @objc(removeStoreObject:)
    @NSManaged public func removeFromStore(_ value: Store)

    @objc(addStore:)
    @NSManaged public func addToStore(_ values: NSSet)

    @objc(removeStore:)
    @NSManaged public func removeFromStore(_ values: NSSet)

}
