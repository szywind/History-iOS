//
//  Person+CoreDataProperties.swift
//  
//
//  Created by 1 on 3/16/18.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }
    
    @NSManaged public var objectId: String?
    @NSManaged public var avatar: String?
    @NSManaged public var name: String?
    @NSManaged public var info: NSData?
    @NSManaged public var type: String?

}
