//
//  FollowManager.swift
//  History
//
//  Created by Zhenyuan Shen on 4/30/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import AVOSCloud

// https://leancloud.cn/docs/status_system.html
class FollowManager {
    static let sharedInstance: FollowManager = {
        return FollowManager()
    }()
    
    func getAllFollowees(user: AVUser?=nil, block: @escaping AVArrayResultBlock) {
        guard user != nil else {
            AVUser.current()?.getFollowees(block)
            return
        }
        user?.getFollowees(block)
    }
    
    func fetchAllFollowees(user: AVUser?=nil, block: @escaping AVArrayResultBlock) {
        guard user != nil else {
            let query = AVUser.current()?.followeeQuery()
            query?.includeKey(LCConstants.FolloweeKey.followee)
            query?.findObjectsInBackground(block)
            return
        }
        let query = user?.followeeQuery()
        query?.includeKey(LCConstants.FolloweeKey.followee)
        query?.findObjectsInBackground(block)
    }
    
    func fetchAllFollowers(user: AVUser?=nil, block: @escaping AVArrayResultBlock) {
        guard user != nil else {
            let query = AVUser.current()?.followerQuery()
            query?.includeKey(LCConstants.FollowerKey.follower)
            query?.findObjectsInBackground(block)
            return
        }
        let query = user?.followeeQuery()
        query?.includeKey(LCConstants.FolloweeKey.followee)
        query?.findObjectsInBackground(block)
    }
    
    func checkExistFollowee(user: AVUser?=nil, block: @escaping AVArrayResultBlock) {
        guard user != nil else {
            let query = AVUser.current()?.followeeQuery()
            query?.whereKey(LCConstants.FolloweeKey.followee, equalTo: user?.objectId)
            query?.findObjectsInBackground(block)
            return
        }
        let query = user?.followeeQuery()
        query?.whereKey(LCConstants.FolloweeKey.followee, equalTo: user?.objectId)
        query?.findObjectsInBackground(block)
    }
    
    
//    func findAllFollowee() {
//        let q = currentUser().followeeQuery()
//        q.whereKey(LCConstants.FolloweeKey.followee, doesNotMatchQuery: blockQuery)
//        q.includeKey(LCConstants.FolloweeKey.followee)
//        q.findObjectsInBackgroundWithBlock { (objectList, error) in
//            if error == nil{
//                var friendList = [Friend]()
//                if let userList = objectList as? [AVUser] {
//                    for object in userList {
//                        friendList.append(Friend(user: object))
//                    }
//                    FriendStore.sharedInstance.CleanAndStoreFriendList(friendList)
//                    NSNotificationCenter.defaultCenter().postNotificationName(Constants.Notify.getContact, object: nil, userInfo: nil )
//
//                    EventManager.sharedInstance.getEventFromUserList(userList)
//                }
//            }
//            block(objectList, error)
//        }
//    }
    

}
