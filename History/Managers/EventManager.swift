//
//  EventManager.swift
//  History
//
//  Created by Zhenyuan Shen on 3/16/18.
//  Copyright © 2018 GSS. All rights reserved.
//


import Foundation
import LeanCloudSocial
import LeanCloud

class EventManager {
    static let sharedInstance: EventManager = {
        return EventManager()
    }()
    
    func getEventInfo(infoFile : AVFile, withBlock block : @escaping (_ data : NSData) -> Void) {
        infoFile.getDataInBackground({ (data, error) in
            if error == nil {
                block(data! as NSData)
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    
    func fetchAllEvent(withBlock block: @escaping (LCQueryResult<LCObject>) -> Void) {
        let query = LCQuery(className: LCConstants.EventKey.className)
        
        query.find { result in
            switch result {
            case .success(let objects):
                for eventObject in objects {
                    CoreDataManager.saveEvent(eventObject: eventObject)
                }
            break // 查询成功
            case .failure(let error):
                print(error)
            }
            block(result)
        }
    }
}
