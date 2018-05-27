//
//  EventEntity+CoreDataProperties.swift
//  
//
//  Created by 1 on 5/25/18.
//
//

import Foundation
import CoreData


extension EventEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventEntity> {
        return NSFetchRequest<EventEntity>(entityName: "EventEntity")
    }

    @NSManaged public var avatarURL: String?
    @NSManaged public var dynasty: String?
    @NSManaged public var end: NSNumber?
    @NSManaged public var infoURL: String?
    @NSManaged public var name: String?
    @NSManaged public var objectId: String
    @NSManaged public var pinyin: String?
    @NSManaged public var start: NSNumber?
    @NSManaged public var type: String?

}
