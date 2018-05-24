//
//  CoreDataManager.swift
//  History
//
//  Created by 1 on 3/15/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import AVOSCloud

class CoreDataManager {
    
    static var context = getContext()
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func save() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
    }
    
    // https://www.youtube.com/watch?v=3b8P44XdwkQ
    class func delete(person: PersonEntity) -> Bool {
        context.delete(person)
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func delete(event: EventEntity) -> Bool {
        context.delete(event)
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    // https://www.youtube.com/watch?v=3b8P44XdwkQ
    class func clear() -> Bool {
        let delete1 = NSBatchDeleteRequest(fetchRequest: PersonEntity.fetchRequest())
        let delete2 = NSBatchDeleteRequest(fetchRequest: EventEntity.fetchRequest())
        do {
            try context.execute(delete1)
            try context.execute(delete2)
            return true
        } catch {
            return false
        }
    }
    
    class func savePerson(personObject: AVObject) -> PersonEntity? {
        if let personId = personObject.objectId {
            for person in checkPersonExistence(personId: personId) {
                if !delete(person: person) {
                    return nil
                }
            }
            let person = PersonEntity(context: context)
            person.objectId = personId
            person.name = personObject.object(forKey: LCConstants.PersonKey.name) as? String
            person.type = personObject.object(forKey: LCConstants.PersonKey.type) as? String
            person.start = personObject.object(forKey: LCConstants.PersonKey.start) as? NSNumber
            person.end = personObject.object(forKey: LCConstants.PersonKey.end) as? NSNumber
            person.dynasty = personObject.object(forKey: LCConstants.PersonKey.dynasty) as? String
//            person.dynasty_detail = personObject.object(forKey: LCConstants.PersonKey.dynasty_detail) as? String
            person.pinyin = personObject.object(forKey: LCConstants.PersonKey.pinyin) as? String

            person.avatarURL = personObject.object(forKey: LCConstants.PersonKey.avatarURL) as? String
            person.infoURL = personObject.object(forKey: LCConstants.PersonKey.infoURL) as? String
                
//            if let avatarDict = personObject.object(forKey: LCConstants.PersonKey.avatarFile) as? NSDictionary {
//                if let url = avatarDict.object(forKey: "url") as? String {
//                    person.avatar = url
//
////                    LCManager.sharedInstance.getFileData(file: avatarFile, withBlock: { (url, error) in
////                        if error == nil && url != nil {
////                            person.avatar = NSData(contentsOf: url!)
////                        } else {
////                            print("[Error] ", error?.localizedDescription)
////                        }
////                    })
//                }
//            }
//
//            if let infoDict = personObject.object(forKey: LCConstants.PersonKey.infoFile) as? NSDictionary {
//                if let url = infoDict.object(forKey: "url") as? String {
//                    person.info = url
//
////                    LCManager.sharedInstance.getFileData(file: infoFile, withBlock: { (url, error) in
////                        if error == nil && url != nil {
////                            person.info = NSData(contentsOf: url!)
////                        }
////                    })
//                }
//            }
            
            
    //        let avatarFile = personObject.get(LCConstants.PersonKey.avatarFile)?.dataValue
    //        let avatarFile = personObject.get(LCConstants.PersonKey.avatarFile)?.dataValue as! AVFile
    //        AvatarManager.sharedInstance.getAvatar(avatarFile: avatarFile) { (image) in
    //            person.avatar = UIImageJPEGRepresentation(image!, 100) as? NSData
    //        }
    //
    //        let infoFile = personObject.value(forKey: LCConstants.PersonKey.infoFile) as! AVFile
    //        PersonManager.sharedInstance.getPersonInfo(infoFile: infoFile) { (info) in
    //            person.info = info
    //        }
            
            save()
            return person
        } else {
            return nil
        }
    }

    class func saveEvent(eventObject: AVObject) -> EventEntity? {
        if let eventId = eventObject.objectId {
            for event in checkEventExistence(eventId: eventId) {
                if !delete(event: event) {
                    return nil
                }
            }
            
            let event = EventEntity(context: context)
            event.objectId = eventId
            event.name = eventObject.object(forKey: LCConstants.EventKey.name) as? String
            event.type = eventObject.object(forKey: LCConstants.EventKey.type) as? String
            event.start = eventObject.object(forKey: LCConstants.EventKey.start) as? NSNumber
            event.end = eventObject.object(forKey: LCConstants.EventKey.end) as? NSNumber
            event.dynasty = eventObject.object(forKey: LCConstants.EventKey.dynasty) as? String
//            event.dynasty_detail = eventObject.object(forKey: LCConstants.EventKey.dynasty_detail) as? String
            event.pinyin = eventObject.object(forKey: LCConstants.EventKey.pinyin) as? String
            
            event.avatarURL = eventObject.object(forKey: LCConstants.EventKey.avatarURL) as? String
            event.infoURL = eventObject.object(forKey: LCConstants.EventKey.infoURL) as? String
            
//            if let avatarDict = eventObject.object(forKey: LCConstants.EventKey.avatarFile) as? NSDictionary {
//                if let url = avatarDict.object(forKey: "url") as? String {
//                    event.avatar = url
////                LCManager.sharedInstance.getFileData(file: avatarFile, withBlock: { (url, error) in
////                    if error == nil && url != nil {
////                        event.avatar = NSData(contentsOf: url!)
////                    }
////                })
//                }
//            }
//
//            if let infoDict = eventObject.object(forKey: LCConstants.EventKey.infoFile) as? NSDictionary {
//                if let url = infoDict.object(forKey: "url") as? String {
//                    event.info = url
////                LCManager.sharedInstance.getFileData(file: infoFile, withBlock: { (url, error) in
////                    if error == nil && url != nil {
////                        event.info = NSData(contentsOf: url!)
////                    }
////                })
//                }
//            }
            
    //        let avatarFile = eventObject.get(LCConstants.EventKey.avatarFile)?.dataValue as! AVFile
    //        AvatarManager.sharedInstance.getAvatar(avatarFile: avatarFile) { (image) in
    //            event.avatar = UIImageJPEGRepresentation(image!, 100) as? NSData
    //        }
    //
    //        let infoFile = eventObject.value(forKey: LCConstants.PersonKey.infoFile) as! AVFile
    //        EventManager.sharedInstance.getEventInfo(infoFile: infoFile) { (info) in
    //            event.info = info
    //        }
            
            save()
            return event
        } else {
            return nil
        }
    }
    
    class func checkPersonExistence(personId: String) -> [PersonEntity] {
        return fetchfilteredPeople(value: personId, format: Constants.CoreData.personIdFilterFormat)
    }
    
    class func checkEventExistence(eventId: String) -> [EventEntity] {
        return fetchfilteredEvents(value: eventId, format: Constants.CoreData.eventIdFilterFormat)
    }
    
    class func fetchAllPeople() -> [PersonEntity] {
        var people = [PersonEntity]()
        let personFetchRequest: NSFetchRequest<PersonEntity> = PersonEntity.fetchRequest()
        // sort by pinyin then time
        let sort = [NSSortDescriptor(key: #keyPath(PersonEntity.pinyin), ascending: true),
                    NSSortDescriptor(key: #keyPath(PersonEntity.start), ascending: true),
                    NSSortDescriptor(key: #keyPath(PersonEntity.end), ascending: true)]
        personFetchRequest.sortDescriptors = sort
        do {
            people = try context.fetch(personFetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return people
    }
    
    class func fetchAllEvents() -> [EventEntity] {
        var events = [EventEntity]()
        let eventFetchRequest: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()
        // sort by pinyin then time
        let sort = [NSSortDescriptor(key: #keyPath(EventEntity.pinyin), ascending: true),
                    NSSortDescriptor(key: #keyPath(EventEntity.start), ascending: true),
                    NSSortDescriptor(key: #keyPath(EventEntity.end), ascending: true)]
        eventFetchRequest.sortDescriptors = sort
        do {
            events = try context.fetch(eventFetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return events
    }
    
    class func fetchfilteredEvents(value: String, format: String) -> [EventEntity] {
        var events = [EventEntity]()
        let eventFetchRequest: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()
        
        // sort by pinyin then time
        let sort = [NSSortDescriptor(key: #keyPath(EventEntity.pinyin), ascending: true),
                    NSSortDescriptor(key: #keyPath(EventEntity.start), ascending: true),
                    NSSortDescriptor(key: #keyPath(EventEntity.end), ascending: true)]
        eventFetchRequest.sortDescriptors = sort
        
        eventFetchRequest.predicate = NSPredicate(format: format, value)
        do {
            events = try context.fetch(eventFetchRequest)
            return events
        } catch {
            print(error.localizedDescription)
        }
        return events
    }
    
    class func fetchfilteredEvents(array: Set<String>, format: String) -> [EventEntity] {
        var events = [EventEntity]()
        let eventFetchRequest: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()
        
        eventFetchRequest.predicate = NSPredicate(format: format, array)
        do {
            events = try context.fetch(eventFetchRequest)
            return events
        } catch {
            print(error.localizedDescription)
        }
        return events
    }
    
    class func fetchfilteredPeople(value: String, format: String) -> [PersonEntity] {
        var people = [PersonEntity]()
        let personFetchRequest: NSFetchRequest<PersonEntity> = PersonEntity.fetchRequest()
        
        personFetchRequest.predicate = NSPredicate(format: format, value)
        do {
            people = try context.fetch(personFetchRequest)
            return people
        } catch {
            print(error.localizedDescription)
        }
        return people
    }
    
    class func fetchfilteredPeople(array: Set<String>, format: String) -> [PersonEntity] {
        var people = [PersonEntity]()
        let personFetchRequest: NSFetchRequest<PersonEntity> = PersonEntity.fetchRequest()
        
        personFetchRequest.predicate = NSPredicate(format: format, array)
        do {
            people = try context.fetch(personFetchRequest)
            return people
        } catch {
            print(error.localizedDescription)
        }
        return people
    }
}
