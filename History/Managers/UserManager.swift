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
    
    func getUserId(user: AVUser?=nil) -> String? {
        guard user != nil else {
            return currentUser().objectId
        }
        return user?.objectId
    }
    
    func getAccountType(user: AVUser?=nil) -> String? {
        guard user != nil else {
            return currentUser().object(forKey: LCConstants.UserKey.accountType) as? String
        }
        return user?.object(forKey: LCConstants.UserKey.accountType) as? String
    }
    
    func getAvatarFile(user: AVUser?=nil) -> AVFile? {
        guard user != nil else {
            return currentUser().object(forKey: LCConstants.UserKey.avatarFile) as? AVFile
        }
        return user?.object(forKey: LCConstants.UserKey.avatarFile) as? AVFile
    }
    
    func getUserLocation(user: AVUser?=nil) -> AVGeoPoint? {
        guard user != nil else {
            return currentUser().object(forKey: LCConstants.UserKey.location) as? AVGeoPoint
        }
        return user?.object(forKey: LCConstants.UserKey.location) as? AVGeoPoint
    }
    
    func getNickname(user: AVUser?=nil) -> String? {
        guard user != nil else {
            return currentUser().object(forKey: LCConstants.UserKey.nickname) as? String
        }
        return user?.object(forKey: LCConstants.UserKey.nickname) as? String
    }
    
    func getFollowTopics(user: AVUser?=nil) -> [String]? {
        guard user != nil else {
            return currentUser().object(forKey: LCConstants.UserKey.followTopics) as? [String] ?? []
        }
        return user?.object(forKey: LCConstants.UserKey.nickname) as? [String] ?? []
    }
    
    func getAvatar(user: AVUser?=nil) -> UIImage? {
        guard user != nil else {
            if let urlStr = currentUser().object(forKey: LCConstants.UserKey.avatarURL) as? String {
                let url = URL(string: urlStr.convertToHttps())
                if let data = try? Data(contentsOf: url!) {
                    return UIImage(data: data)
                }
            }
            return UIImage(named: "default")
        }
       
        if let urlStr = user?.object(forKey: LCConstants.UserKey.avatarURL) as? String {
            let url = URL(string: urlStr.convertToHttps())
            if let data = try? Data(contentsOf: url!) {
                return UIImage(data: data)
            }
        }
        return UIImage(named: "default")
    }
    
    func logout() {
        AVUser.logOut()
    }
    
    func setUserLocation(user: AVUser?=nil) -> AVGeoPoint {
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
    
    func setFollowTopics(withBlock block : @escaping AVBooleanResultBlock) {
        currentUser().setObject(Array(State.currentFollowTopics), forKey: LCConstants.UserKey.followTopics)
        currentUser().saveInBackground(block)
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
                self.setUserLocation()
                self.currentUser().saveInBackground(block)
            }
        }
    }
    
    func findHotUsers(pageSize: Int=10, withBlock block: @escaping AVArrayResultBlock) {
        let query = AVUser.query()
        query.order(byDescending: LCConstants.UserKey.followers)
        query.limit = pageSize
        query.findObjectsInBackground({ (objects, error) in
            block(objects, error)
        })
    }
    
    func updateCounter(forKey key: String, amount: NSNumber, user: AVUser?=nil) {
        currentUser().saveInBackground({ (succeed, error) in
            if succeed {
                self.currentUser().incrementKey(key, byAmount: amount)
                self.currentUser().fetchWhenSave = true
                self.currentUser().saveInBackground()
                
                // send notification to user to increment his/her follower field
                // TODO
            } else {
                print(error?.localizedDescription)
            }
        })
    }
}
