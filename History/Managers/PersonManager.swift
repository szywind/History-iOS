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

class PersonManager {
    static let sharedInstance: PersonManager = {
        return PersonManager()
    }()
    
    
//    func fetchAllPeople(withBlock block: @escaping (_ people: [Person]) -> Void) {
//        let query = LCQuery(className: LCConstants.PersonKey.className)
//        query.find { result in
//            var people = [Person]()
//            switch result {
//            case .success(let objects):
//                for object in objects {
//                    people.append(Person(object))
//                }
//                break
//            case .failure(let error):
//                print(error)
//                break
//            }
//            block(people)
//        }
//    }


    
//    func fetchAllPeople() {
//        let q = AVQuery(className: LCConstants.PersonKey.className)
//        q.findObjectsInBackground { (objects, error) in
//            if error == nil{
//                for personObject in objects! {
//                    CoreDataManager.savePerson(personObject: personObject as! AVObject)
//                }
//            }
//        }
//    }
    
    func fetchAllPeople(withBlock block: @escaping (LCQueryResult<LCObject>) -> Void) {
        let query = LCQuery(className: LCConstants.PersonKey.className)

        query.find { result in
            switch result {
            case .success(let objects):
                for personObject in objects {
                    CoreDataManager.savePerson(personObject: personObject)
                }
                break // 查询成功
            case .failure(let error):
                print(error)
            }
            block(result)
        }
    }
}

