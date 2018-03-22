//
//  Person+CoreDataProperties.swift
//  
//
//  Created by 1 on 3/22/18.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var avatar: String?
    @NSManaged public var info: String?
    @NSManaged public var name: String?
    @NSManaged public var objectId: String?
    @NSManaged public var type: String?
    @NSManaged public var start: NSNumber?
    @NSManaged public var end: NSNumber?
    @NSManaged public var dynasty: String?
    @NSManaged public var dynasty_detail: String?

}
