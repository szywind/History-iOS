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

class CoreDataManager {
    
    static var context = getContext()
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
//    class func savePeople(lcobj) {
//        let person = Person(context: context)
//        person.name = name
//        person.avatar
//        person.type =
//        person.info
//    }
//
//    class func saveEvents() {
//        let event = Event(context: context)
//        event.name = name
//        event.avatar
//        event.type =
//        event.info
//    }
    
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
    
    class func fetchEvents() -> [Event] {
        var events = [Event]()
        let eventFetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        do {
            events = try context.fetch(eventFetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return events
    }
}
