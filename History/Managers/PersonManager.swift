//
//  LCManager.swift
//  History
//
//  Created by Zhenyuan Shen on 14/03/2018.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import AVOSCloud

class PersonManager {
    static let sharedInstance: PersonManager = {
        return PersonManager()
    }()
    
    func fetchAllPeopleFromLC(withBlock block: @escaping AVArrayResultBlock) {
        
        let query = AVQuery(className: LCConstants.PersonKey.className)
        query.countObjectsInBackground { (number, error) in
            if error == nil {
                self.fetchAllPeopleFromLC(number: number, withBlock: block)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func fetchAllPeopleFromLC(number: Int, withBlock block: @escaping AVArrayResultBlock) {
        var base = 0
        let limit = 100
        
        while base < number {
            let query = AVQuery(className: LCConstants.PersonKey.className)
            query.skip = base
            query.limit = limit    
            query.findObjectsInBackground({ (objects, error) in
                if error == nil && objects != nil {
                    for personObject in objects! {
                        CoreDataManager.savePerson(personObject: personObject as! AVObject)
                    }
                } else {
                    print(error?.localizedDescription)
                }
                block(objects, error)
            })
            base += limit
        }
    }
}

