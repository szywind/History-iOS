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
    var avatar: UIImage?
    var type: String?
    var info: String
    
    init(name: String?, avatar: UIImage?, type: String?) {
        self.name = name
        self.avatar = avatar
        self.type = type
        self.info = Constants.Default.defaultInfo
    }
    
    init(person: Person) {
        self.name = person.name
        if let avatar_ = person.avatar {
            self.avatar = UIImage(data: avatar_ as Data)
        } else {
            self.avatar = UIImage(named: Constants.Default.defaultAvatar)
        }
        
        self.type = person.type
        
        
        if let info_ = person.info {
            self.info = NSString(data: info_ as Data, encoding: String.Encoding.utf8.rawValue)! as String
        } else {
            self.info = Constants.Default.defaultInfo
        }
    }
    
    init(event: Event) {
        self.name = event.name
        if let avatar_ = event.avatar {
            self.avatar = UIImage(data: avatar_ as Data)
        } else {
            self.avatar = UIImage(named: Constants.Default.defaultAvatar)
        }
        
        self.type = event.type
        
        if let info_ = event.info {
            self.info = NSString(data: info_ as Data, encoding: String.Encoding.utf8.rawValue)! as String
        } else {
            self.info = Constants.Default.defaultInfo
        }
    }
    
    static func getRecords(events: [Event]) -> [Record] {
        var records = [Record]()
        for event in events {
            records.append(Record(event: event))
        }
        return records
    }
    
    static func getRecords(people: [Person]) -> [Record] {
        var records = [Record]()
        for person in people {
            records.append(Record(person: person))
        }
        return records
    }
}
