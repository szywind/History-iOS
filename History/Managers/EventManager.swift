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
        query.countObjectsInBackground { (number, error) in
            if error == nil {
                self.fetchAllEventsFromLC(number: number, withBlock: block)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func fetchAllEventsFromLC(number: Int, withBlock block: @escaping AVArrayResultBlock) {
        var base = 0
        let limit = 100
        
        while base < number {
            let query = AVQuery(className: LCConstants.EventKey.className)
            query.limit = limit
            query.skip = base
            DispatchQueue.global(qos: .userInitiated).async {
                query.findObjectsInBackground({ (objects, error) in
                    block(objects, error)
                })
            }
            base += limit
        }
    }
}
