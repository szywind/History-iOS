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
    class func delete(person: Person) -> Bool {
        context.delete(person)
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func delete(event: Event) -> Bool {
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
        let delete1 = NSBatchDeleteRequest(fetchRequest: Person.fetchRequest())
        let delete2 = NSBatchDeleteRequest(fetchRequest: Event.fetchRequest())
        do {
            try context.execute(delete1)
            try context.execute(delete2)
            return true
        } catch {
            return false
        }
    }
    
    class func savePerson(personObject: AVObject) {
        if let personId = personObject.objectId {
            for person in checkPersonExistence(personId: personId) {
                if !delete(person: person) {
                    return
                }
            }
            let person = Person(context: context)
            person.objectId = personId
            person.name = personObject.object(forKey: LCConstants.PersonKey.name) as? String
            person.type = personObject.object(forKey: LCConstants.PersonKey.type) as? String
            person.start = personObject.object(forKey: LCConstants.PersonKey.start) as? NSNumber
            person.end = personObject.object(forKey: LCConstants.PersonKey.end) as? NSNumber
            person.dynasty = personObject.object(forKey: LCConstants.PersonKey.dynasty) as? String
            person.dynasty_detail = personObject.object(forKey: LCConstants.PersonKey.dynasty_detail) as? String
            person.pinyin = personObject.object(forKey: LCConstants.PersonKey.pinyin) as? String

            if let avatarDict = personObject.object(forKey: LCConstants.PersonKey.avatarFile) as? NSDictionary {
                if let url = avatarDict.object(forKey: "url") as? String {
                    person.avatar = url

//                    LCManager.sharedInstance.getFileData(file: avatarFile, withBlock: { (url, error) in
//                        if error == nil && url != nil {
//                            person.avatar = NSData(contentsOf: url!)
//                        } else {
//                            print("[Error] ", error?.localizedDescription)
//                        }
//                    })
                }
            }

            if let infoDict = personObject.object(forKey: LCConstants.PersonKey.infoFile) as? NSDictionary {
                if let url = infoDict.object(forKey: "url") as? String {
                    person.info = url
                    
//                    LCManager.sharedInstance.getFileData(file: infoFile, withBlock: { (url, error) in
//                        if error == nil && url != nil {
//                            person.info = NSData(contentsOf: url!)
//                        }
//                    })
                }
            }
            
            
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
        }
    }

    class func saveEvent(eventObject: AVObject) {
        if let eventId = eventObject.objectId {
            for event in checkEventExistence(eventId: eventId) {
                if !delete(event: event) {
                    return
                }
            }
            
            let event = Event(context: context)
            event.objectId = eventId
            event.name = eventObject.object(forKey: LCConstants.EventKey.name) as? String
            event.type = eventObject.object(forKey: LCConstants.EventKey.type) as? String
            event.start = eventObject.object(forKey: LCConstants.EventKey.start) as? NSNumber
            event.end = eventObject.object(forKey: LCConstants.EventKey.end) as? NSNumber
            event.dynasty = eventObject.object(forKey: LCConstants.EventKey.dynasty) as? String
            event.dynasty_detail = eventObject.object(forKey: LCConstants.EventKey.dynasty_detail) as? String
            event.pinyin = eventObject.object(forKey: LCConstants.EventKey.pinyin) as? String
            
            if let avatarDict = eventObject.object(forKey: LCConstants.EventKey.avatarFile) as? NSDictionary {
                if let url = avatarDict.object(forKey: "url") as? String {
                    event.avatar = url
//                LCManager.sharedInstance.getFileData(file: avatarFile, withBlock: { (url, error) in
//                    if error == nil && url != nil {
//                        event.avatar = NSData(contentsOf: url!)
//                    }
//                })
                }
            }
            
            if let infoDict = eventObject.object(forKey: LCConstants.EventKey.infoFile) as? NSDictionary {
                if let url = infoDict.object(forKey: "url") as? String {
                    event.info = url
//                LCManager.sharedInstance.getFileData(file: infoFile, withBlock: { (url, error) in
//                    if error == nil && url != nil {
//                        event.info = NSData(contentsOf: url!)
//                    }
//                })
                }
            }
            
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
        }
    }
    
    class func checkPersonExistence(personId: String) -> [Person] {
        return fetchfilteredPeople(value: personId, format: Constants.CoreData.personIdFilterFormat)
    }
    
    class func checkEventExistence(eventId: String) -> [Event] {
        return fetchfilteredEvents(value: eventId, format: Constants.CoreData.eventIdFilterFormat)
    }
    
    class func fetchAllPeople() -> [Person] {
        var people = [Person]()
        let personFetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        // sort by time
        let sort = [NSSortDescriptor(key: #keyPath(Person.start), ascending: true),
                    NSSortDescriptor(key: #keyPath(Person.end), ascending: true)]
        personFetchRequest.sortDescriptors = sort
        do {
            people = try context.fetch(personFetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return people
    }
    
    class func fetchAllEvents() -> [Event] {
        var events = [Event]()
        let eventFetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        // sort by time
        let sort = [NSSortDescriptor(key: #keyPath(Event.start), ascending: true),
                    NSSortDescriptor(key: #keyPath(Event.end), ascending: true)]
        eventFetchRequest.sortDescriptors = sort
        do {
            events = try context.fetch(eventFetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return events
    }
    
    class func fetchfilteredEvents(value: String, format: String) -> [Event] {
        var events = [Event]()
        let eventFetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        
        eventFetchRequest.predicate = NSPredicate(format: format, value)
        do {
            events = try context.fetch(eventFetchRequest)
            return events
        } catch {
            print(error.localizedDescription)
        }
        return events
    }
    
    class func fetchfilteredPeople(value: String, format: String) -> [Person] {
        var people = [Person]()
        let personFetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        personFetchRequest.predicate = NSPredicate(format: format, value)
        do {
            people = try context.fetch(personFetchRequest)
            return people
        } catch {
            print(error.localizedDescription)
        }
        return people
    }
}
