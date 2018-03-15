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
        let person = Person(context: context)
        person.name = personObject.get(LCConstants.PersonKey.name)?.stringValue
        person.type = (personObject.get(LCConstants.PersonKey.type)?.int16Value)!
        
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

    class func saveEvent(eventObject: LCObject) {
        let event = Person(context: context)
        event.name = eventObject.get(LCConstants.EventKey.name)?.stringValue
        event.type = (eventObject.get(LCConstants.EventKey.type)?.int16Value)!
        
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
    
    class func fetchPeople() -> [Person] {
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
    
    class func fetchfilteredEvents(type: Int16) -> [Event] {
        var events = [Event]()
        let eventFetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        
        eventFetchRequest.predicate = NSPredicate(format: "type == %d", type)
        do {
            events = try context.fetch(eventFetchRequest)
            return events
        } catch {
            print(error.localizedDescription)
        }
        return events
    }
}
