//
//  LCManager.swift
//  History
//
//  Created by Zhenyuan Shen on 14/03/2018.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import LeanCloudSocial
import LeanCloud

class PeopleManager {
    static let sharedInstance: PeopleManager = {
        return PeopleManager()
    }()
    
//    func fetchAll
//        AVObject.fetchAll(inBackground: eventObjectList) { (objectList, error) in
//        if error != nil {
//        //                print(error)
//        } else {
//        //                print(objectList)
//        var eventList = [Event]()
//        if let objectList = objectList as? [AVObject] {
//            for object in objectList {
//                    eventList.append(Event(eventAVObject: object))
//                }
//                eventList.mainPageUpdate()
//                EventStore.sharedInstance.eventList = eventList
//                MessageStore.sharedInstance.setUnreadEventChatNumber()
//                NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.Notify.getEvent), object: nil, userInfo: nil )
//            }
//        }
//    }
}

class EventManager {
    static let sharedInstance: EventManager = {
        return EventManager()
    }()
}
