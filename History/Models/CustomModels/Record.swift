//
//  Record.swift
//  History
//
//  Created by Zhenyuan Shen on 3/13/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

class Record {
    
    var name: String?
    var avatarURL: String? // TODO
    var type: String?
    var infoURL: String?
    var start: Int16?
    var end: Int16?
    var dynasty: String?
    var pinyin: String?
    var objectId: String?
    
    init(name: String?, avatarURL: String?, type: String?, start: Int16?, end: Int16?, dynasty: String?, pinyin: String?, objectId: String, infoURL: String?) {
        self.name = name
        self.avatarURL = avatarURL
        self.type = type
        self.infoURL = infoURL
        self.start = start
        self.end = end
        self.dynasty = dynasty
        self.pinyin = pinyin
        self.objectId = objectId
    }
    
    init(person: PersonEntity) {
        self.name = person.name
        self.type = person.type
        self.start = person.start as? Int16
        self.end = person.end as? Int16
        self.dynasty = person.dynasty
        self.pinyin = person.pinyin
        self.objectId = "p" + person.objectId
        self.avatarURL = person.avatarURL
        self.infoURL = person.infoURL
    }
    
    init(event: EventEntity) {
        self.name = event.name
        self.type = event.type
        self.start = event.start as? Int16
        self.end = event.end as? Int16
        self.dynasty = event.dynasty
        self.pinyin = event.pinyin
        self.objectId = "e" + event.objectId
        self.avatarURL = event.avatarURL
        self.infoURL = event.infoURL
    }
    
    static func getRecords(events: [EventEntity]) -> [Record] {
        var records = [Record]()
        for event in events {
            records.append(Record(event: event))
        }
        return records
    }
    
    static func getRecords(people: [PersonEntity]) -> [Record] {
        var records = [Record]()
        for person in people {
            records.append(Record(person: person))
        }
        return records
    }
}
