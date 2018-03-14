//
//  Event+CoreDataProperties.swift
//  
//
//  Created by 1 on 3/15/18.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var avatar: NSData?
    @NSManaged public var name: String?
    @NSManaged public var type: Int16
    @NSManaged public var info: String?

}
