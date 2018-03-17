//
//  Event+CoreDataProperties.swift
//  
//
//  Created by 1 on 3/16/18.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var objectId: String?
    @NSManaged public var avatar: String?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var info: String?

}
