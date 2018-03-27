//
//  Person+CoreDataProperties.swift
//  
//
//  Created by Cloudream on 27/03/2018.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var avatar: String?
    @NSManaged public var dynasty: String?
    @NSManaged public var dynasty_detail: String?
    @NSManaged public var end: NSNumber?
    @NSManaged public var info: String?
    @NSManaged public var name: String?
    @NSManaged public var objectId: String?
    @NSManaged public var pinyin: String?
    @NSManaged public var start: NSNumber?
    @NSManaged public var type: String?

}
