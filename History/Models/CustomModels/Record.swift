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
    var info: String?
    var start: Int16?
    var end: Int16?
    var dynasty: String?
    var dynasty_detail: String?
    
    init(name: String?, avatar: UIImage?, type: String?, start: Int16?, end: Int16?, dynasty: String?, dynasty_detail: String?, info: String = Constants.Default.defaultInfo) {
        self.name = name
        self.avatar = avatar
        self.type = type
        self.info = info
        self.start = start
        self.end = end
        self.dynasty = dynasty
        self.dynasty_detail = dynasty_detail
    }
    
    init(person: Person) {
        self.name = person.name
        self.type = person.type
        self.start = person.start as? Int16
        self.end = person.end as? Int16
        self.dynasty = person.dynasty
        self.dynasty_detail = person.dynasty_detail
        
        if let avatar_ = person.avatar {
            let url = URL(string: avatar_.convertToHttps())
            if let data = try? Data(contentsOf: url!) {
                self.avatar = UIImage(data: data)
            } else {
                self.avatar = UIImage(named: Constants.Default.defaultAvatar)
            }
        } else {
            self.avatar = UIImage(named: Constants.Default.defaultAvatar)
        }
        
        if let info_ = person.info {
            let url = URL(string: info_.convertToHttps())
            if let data = try? Data(contentsOf: url!) {
                self.info = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
            } else {
                self.info = Constants.Default.defaultInfo
            }
        } else {
            self.info = Constants.Default.defaultInfo
        }
    }
    
    init(event: Event) {
        self.name = event.name
        self.type = event.type
        self.start = event.start as? Int16
        self.end = event.end as? Int16
        self.dynasty = event.dynasty
        self.dynasty_detail = event.dynasty_detail
        
        if let avatar_ = event.avatar {
            let url = URL(string: avatar_.convertToHttps())
            if let data = try? Data(contentsOf: url!) {
                self.avatar = UIImage(data: data)
            } else {
                self.avatar = UIImage(named: Constants.Default.defaultAvatar)
            }
        } else {
            self.avatar = UIImage(named: Constants.Default.defaultAvatar)
        }
        
        if let info_ = event.info {
            let url = URL(string: info_.convertToHttps())
            if let data = try? Data(contentsOf: url!) {
                self.info = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
            } else {
                self.info = Constants.Default.defaultInfo
            }
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
