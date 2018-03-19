//
//  EventManager.swift
//  History
//
//  Created by Zhenyuan Shen on 3/16/18.
//  Copyright © 2018 GSS. All rights reserved.
//


import Foundation
import AVOSCloud

class EventManager {
    static let sharedInstance: EventManager = {
        return EventManager()
    }()
    
    func fetchAllEventsFromLC(withBlock block: @escaping AVArrayResultBlock) {
        let query = AVQuery(className: LCConstants.EventKey.className)
        
        query.findObjectsInBackground({ (objects, error) in
            if error == nil && objects != nil {
                for eventObject in objects! {
                    CoreDataManager.saveEvent(eventObject: eventObject as! AVObject)
                }
            } else {
                print(error?.localizedDescription)
            }
            block(objects, error)
        })
    }
}
