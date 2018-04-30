//
//  UserManager.swift
//  History
//
//  Created by Zhenyuan Shen on 3/11/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import AVOSCloud

class UserManager {
    static let sharedInstance: UserManager = {
        return UserManager()
    }()
    
    private init(){}
    
    func currentUser() -> AVUser {
        return AVUser.current()!
    }
    
    func isLogin() -> Bool {
        return AVUser.current() != nil
    }
    
    func getUserId(user: AVUser?) -> String? {
        guard user != nil else {
            return currentUser().objectId
        }
        return user?.objectId
    }
    
    func getAccountType(user: AVUser?) -> String? {
        guard user != nil else {
            return currentUser().object(forKey: LCConstants.UserKey.accountType) as? String
        }
        return user?.object(forKey: LCConstants.UserKey.accountType) as? String
    }
    
    func getAvatarFile(user: AVUser?) -> AVFile? {
        guard user != nil else {
            return currentUser().object(forKey: LCConstants.UserKey.avatarFile) as? AVFile
        }
        return user?.object(forKey: LCConstants.UserKey.avatarFile) as? AVFile
    }
    
    func getUserLocation(user: AVUser?) -> AVGeoPoint? {
        guard user != nil else {
            return currentUser().object(forKey: LCConstants.UserKey.location) as? AVGeoPoint
        }
        return user?.object(forKey: LCConstants.UserKey.location) as? AVGeoPoint
    }
    
    func logout() {
        AVUser.logOut()
    }
    
    func setUserLocation(user: AVUser?) -> AVGeoPoint {
        var curLocation = AVGeoPoint()
        if let location = State.currentLocation {
            curLocation = AVGeoPoint(location: location)
            if user == nil {
                currentUser().setObject(curLocation, forKey: LCConstants.UserKey.location)
            } else {
                user?.setObject(curLocation, forKey: LCConstants.UserKey.location)
            }
        }
        return curLocation
    }
    // TODO
    
    func findUser(key: String = LCConstants.UserKey.username, value: String, withBlock block: @escaping AVArrayResultBlock) {
        let query = AVUser.query()
        query.whereKey(key, equalTo: value)
        query.findObjectsInBackground({ (objects, error) in
            block(objects, error)
        })
    }
    
    func saveUser(nickname: String, image: UIImage, withBlock block : @escaping AVBooleanResultBlock) {
            
        AvatarManager.sharedInstance.updateAvatarWithImage(image: image) { (succeed, error) in
            if succeed {
                self.currentUser().setObject(nickname, forKey: LCConstants.UserKey.nickname)
//                self.currentUser().setObject(phone, forKey: LCConstants.UserKey.phone)
//                self.currentUser().setObject(gender, forKey: LCConstants.UserKey.gender)
                self.setUserLocation(user: nil)
                self.currentUser().saveInBackground(block)
            }
        }
    }
    
    func findHotUsers(pageSize: Int, withBlock block: @escaping AVArrayResultBlock) {
        let query = AVUser.query()

        query.findObjectsInBackground({ (objects, error) in
            block(objects, error)
        })
    }
}
