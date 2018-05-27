//
//  LocalDataManager.swift
//  History
//
//  Created by 1 on 3/24/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import AVOSCloud

class LocalDataManager {
    static let sharedInstance: LocalDataManager = {
        return LocalDataManager()
    }()
    
    var isSorted = false
    var allPeople = [Record]()
    var allEvents = [Record]()
    var events = [Record]()
    var geo = [Record]()
    var art = [Record]()
    var tech = [Record]()
    var allRecords = [Record]()

    static let index2dynasty = ["三皇五帝", "夏", "商", "西周", "春秋", "战国", "秦", "西汉", "东汉", "三国", "西晋", "东晋", "南北朝",
                         "隋", "唐", "五代十国", "北宋", "辽", "金", "南宋", "元", "明", "清"]
    
    static var dynasty2index = [String: Int]()
    
    private init() {
//        NotificationCenter.default.addObserver(self, selector: #selector(self.setupData), name: NSNotification.Name(rawValue: Constants.Notification.fetchDataFromLC), object: nil)
        for index in 0..<LocalDataManager.index2dynasty.count {
            LocalDataManager.dynasty2index[LocalDataManager.index2dynasty[index]] = index
        }
        isSorted = false
    }
    
    func mergeSortedAllRecords() {
        allRecords.removeAll()
        var ind1 = 0
        var ind2 = 0
        while ind1 < allPeople.count && ind2 < allEvents.count {
            if allPeople[ind1].start! < allEvents[ind2].start! ||
                (allPeople[ind1].start! == allEvents[ind2].start! && allPeople[ind1].end! <= allEvents[ind2].end!) {
                allRecords.append(allPeople[ind1])
                ind1 = ind1 + 1
            } else {
                allRecords.append(allEvents[ind2])
                ind2 = ind2 + 1
            }
        }
        
        if ind1 == allPeople.count {
            allRecords.append(contentsOf: allEvents[ind2...])
        } else {
            allRecords.append(contentsOf: allPeople[ind1...])
//            allRecords = allRecords + allPeople[ind1...]
        }
    }
    
    func setupEncyclopediaData() {
        isSorted = true
        allPeople = Record.getRecords(people: CoreDataManager.fetchAllPeople())
        allEvents = Record.getRecords(events: CoreDataManager.fetchAllEvents())
        
//        allPeople.sort { (record1, record2) -> Bool in
//            record1.start! < record2.start! || (record1.start! == record2.start! && record1.end! < record2.end!)
//        }
//        allEvents.sort { (record1, record2) -> Bool in
//            record1.start! < record2.start! || (record1.start! == record2.start! && record1.end! < record2.end!)
//        }
        
        //        allRecords = allPeople + allEvents
        //        allRecords.sorted(by: {$0.start! < $1.start! || ($0.start! == $1.start! && $0.end! < $1.end!)})
        
//        mergeSortedAllRecords()
        events = Record.getRecords(events: CoreDataManager.fetchfilteredEvents(value: "event", format: Constants.CoreData.eventTypeFilterFormat))
        geo = Record.getRecords(events: CoreDataManager.fetchfilteredEvents(value: "geography", format: Constants.CoreData.eventTypeFilterFormat))
        art = Record.getRecords(events: CoreDataManager.fetchfilteredEvents(value: "art", format: Constants.CoreData.eventTypeFilterFormat))
        tech = Record.getRecords(events: CoreDataManager.fetchfilteredEvents(value: "technology", format: Constants.CoreData.eventTypeFilterFormat))
    }
    
    func getFollowingTopics() -> [Record] {
        let followingTopics = Record.getRecords(people: CoreDataManager.fetchfilteredPeople(array: State.currentSubscribeTopics, format: Constants.CoreData.personNameFilterFormat))
            + Record.getRecords(events: CoreDataManager.fetchfilteredEvents(array: State.currentSubscribeTopics, format: Constants.CoreData.eventNameFilterFormat))
        return followingTopics
    }
    
    @objc func setupData() {
        setupEncyclopediaData()

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notification.refreshUI), object: nil)
    }
    
    func addRecord(person: PersonEntity) {
        let record = Record(person: person)
        allPeople.append(record)
//        allRecords.append(record)
        
    }
    
    func addRecord(personObject: AVObject) {
        let objectId = "p" + personObject.objectId!
        let name = personObject.object(forKey: LCConstants.PersonKey.name) as? String
        let type = personObject.object(forKey: LCConstants.PersonKey.type) as? String
        let start = personObject.object(forKey: LCConstants.PersonKey.start) as? Int16
        let end = personObject.object(forKey: LCConstants.PersonKey.end) as? Int16
        let dynasty = personObject.object(forKey: LCConstants.PersonKey.dynasty) as? String
//        let dynasty_detail = personObject.object(forKey: LCConstants.PersonKey.dynasty_detail) as? String
        let pinyin = personObject.object(forKey: LCConstants.PersonKey.pinyin) as? String
        
        let avatarURL = personObject.object(forKey: LCConstants.PersonKey.avatarURL) as? String
        let infoURL = personObject.object(forKey: LCConstants.PersonKey.infoURL) as? String
        
        let record = Record(name: name, avatarURL: avatarURL, type: type, start: start, end: end, dynasty: dynasty, pinyin: pinyin, objectId: objectId, infoURL: infoURL)
        
        allPeople.append(record)
//        allRecords.append(record)
    }
    
    func addRecord(event: EventEntity) {
        let record = Record(event: event)
        allEvents.append(record)
//        allRecords.append(record)
        switch record.type {
        case "event":
            events.append(record)
        case "geography":
            geo.append(record)
        case "art":
            art.append(record)
        case "technology":
            tech.append(record)
        default:
            break
        }
    }
    
    func addRecord(eventObject: AVObject) {
        let objectId = "e" + eventObject.objectId!
        let name = eventObject.object(forKey: LCConstants.EventKey.name) as? String
        let type = eventObject.object(forKey: LCConstants.EventKey.type) as? String
        let start = eventObject.object(forKey: LCConstants.EventKey.start) as? Int16
        let end = eventObject.object(forKey: LCConstants.EventKey.end) as? Int16
        let dynasty = eventObject.object(forKey: LCConstants.EventKey.dynasty) as? String
//        let dynasty_detail = eventObject.object(forKey: LCConstants.EventKey.dynasty_detail) as? String
        let pinyin = eventObject.object(forKey: LCConstants.EventKey.pinyin) as? String
        
        let avatarURL = eventObject.object(forKey: LCConstants.EventKey.avatarURL) as? String
        let infoURL = eventObject.object(forKey: LCConstants.EventKey.infoURL) as? String
        
        let record = Record(name: name, avatarURL: avatarURL, type: type, start: start, end: end, dynasty: dynasty, pinyin: pinyin, objectId: objectId, infoURL: infoURL)
        
        allEvents.append(record)
//        allRecords.append(record)
        switch record.type {
        case "event":
            events.append(record)
        case "geography":
            geo.append(record)
        case "art":
            art.append(record)
        case "technology":
            tech.append(record)
        default:
            break
        }
    }
    
    func clearAll() {
        isSorted = false
        allPeople.removeAll()
        allEvents.removeAll()
        events.removeAll()
        geo.removeAll()
        art.removeAll()
        tech.removeAll()
//        allRecords.removeAll()
    }
    
    func sort() {
        if !isSorted {
            allPeople = allPeople.sorted(by: {$0.pinyin! < $1.pinyin!})
            allEvents = allEvents.sorted(by: {$0.pinyin! < $1.pinyin!})
            events = events.sorted(by: {$0.pinyin! < $1.pinyin!})
            geo = geo.sorted(by: {$0.pinyin! < $1.pinyin!})
            art = art.sorted(by: {$0.pinyin! < $1.pinyin!})
            tech = tech.sorted(by: {$0.pinyin! < $1.pinyin!})
//            allRecords = allRecords.sorted(by: {$0.pinyin! < $1.pinyin!})
            isSorted = true
        }
    }
}

