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
import LeanCloud
import LeanCloudSocial

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
    
    class func savePerson(personObject: LCObject) {
        if let personId = personObject.objectId?.stringValue {
            if checkPersonExistence(personId: personId) {
                return
            }
            let person = Person(context: context)
            person.objectId = personId
            person.name = personObject.get(LCConstants.PersonKey.name)?.stringValue
            person.type = personObject.get(LCConstants.PersonKey.type)?.stringValue
            
            person.avatar = personObject.get(LCConstants.PersonKey.avatarFile)?.dataValue as? NSData
            person.info = personObject.get(LCConstants.PersonKey.infoFile)?.dataValue as? NSData
            
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

    class func saveEvent(eventObject: LCObject) {
        if let eventId = eventObject.objectId?.stringValue {
            if checkEventExistence(eventId: eventId) {
                return
            }
            let event = Person(context: context)
            event.objectId = eventObject.objectId?.stringValue
            event.name = eventObject.get(LCConstants.EventKey.name)?.stringValue
            event.type = eventObject.get(LCConstants.EventKey.type)?.stringValue
            
    //        event.avatar = eventObject.value(forKey: LCConstants.EventKey.avatarFile) as! NSData
            event.avatar = eventObject.get(LCConstants.EventKey.avatarFile)?.dataValue as? NSData
            event.info = eventObject.get(LCConstants.EventKey.infoFile)?.dataValue as? NSData
            
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
    
    class func checkPersonExistence(personId: String) -> Bool {
        var people = fetchfilteredPeople(value: personId, format: Constants.CoreData.personIdFilterFormat)
        return people.count > 0
    }
    
    class func checkEventExistence(eventId: String) -> Bool {
        var events = fetchfilteredEvents(value: eventId, format: Constants.CoreData.eventIdFilterFormat)
        return events.count > 0
    }
    
    class func fetchAllPeople() -> [Person] {
        var people = [Person]()
        let personFetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
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
