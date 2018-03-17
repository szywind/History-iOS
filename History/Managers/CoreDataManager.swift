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
    
    class func savePerson(personObject: AVObject) {
        if let personId = personObject.objectId {
            if checkPersonExistence(personId: personId) {
                return
            }
            let person = Person(context: context)
            person.objectId = personId
            person.name = personObject.object(forKey: LCConstants.PersonKey.name) as? String
            person.type = personObject.object(forKey: LCConstants.PersonKey.type) as? String
            
            if let avatarDict = personObject.object(forKey: LCConstants.PersonKey.avatarFile) as? NSDictionary {
                if let url = avatarDict.object(forKey: "url") as? String {
//                    let imgUrl = URL(string: url)
//                    person.avatar = NSData(contentsOf: imgUrl!)
                    person.avatar = url
//                    let avatarFile = AVFile(remoteURL: imgUrl!)
//                    let avatarFile = AVFile(avObject: AVObject(objectId: objectId))
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
//                if let url = infoDict.object(forKey: "url") as? URL {
//                    let infoFile = AVFile(remoteURL: url)
//                    LCManager.sharedInstance.getFileData(file: infoFile, withBlock: { (url, error) in
//                        if error == nil && url != nil {
//                            person.info = NSData(contentsOf: url!)
//                        }
//                    })
//                }
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
            if checkEventExistence(eventId: eventId) {
                return
            }
            
            let event = Event(context: context)
            event.objectId = eventId
            event.name = eventObject.object(forKey: LCConstants.EventKey.name) as? String
            event.type = eventObject.object(forKey: LCConstants.EventKey.type) as? String
            
            if let avatarFile = eventObject.object(forKey: LCConstants.EventKey.avatarFile) as? NSDictionary {
////                event.avatar = avatarFile.object(forKey: "url") as? String
//                LCManager.sharedInstance.getFileData(file: avatarFile, withBlock: { (url, error) in
//                    if error == nil && url != nil {
//                        event.avatar = NSData(contentsOf: url!)
//                    }
//                })
            }
            
            if let infoFile = eventObject.object(forKey: LCConstants.EventKey.infoFile) as? NSDictionary {
////                event.info = infoFile.object(forKey: "url") as? String
//                LCManager.sharedInstance.getFileData(file: infoFile, withBlock: { (url, error) in
//                    if error == nil && url != nil {
//                        event.info = NSData(contentsOf: url!)
//                    }
//                })
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
    
    class func checkPersonExistence(personId: String) -> Bool {
        let people = fetchfilteredPeople(value: personId, format: Constants.CoreData.personIdFilterFormat)
        return people.count > 0
    }
    
    class func checkEventExistence(eventId: String) -> Bool {
        let events = fetchfilteredEvents(value: eventId, format: Constants.CoreData.eventIdFilterFormat)
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
