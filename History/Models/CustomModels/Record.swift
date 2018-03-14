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
    var type: Int16
    var info: String
    
    init(name: String?, avatar: UIImage?, type: Int16) {
        self.name = name
        self.avatar = avatar
        self.type = type
        self.info = Constants.Default.defaultInfo
    }
    
    init(person: Person) {
        self.name = person.name
        self.avatar = UIImage(data: person.avatar! as Data)
        self.type = 0
        self.info = person.info!
    }
    
    init(event: Event) {
        self.name = event.name
        self.avatar = UIImage(data: event.avatar! as Data)
        self.type = event.type
        self.info = event.info!
    }
}
