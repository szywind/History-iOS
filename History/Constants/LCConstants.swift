//
//  LCConstants.swift
//  History
//
//  Created by Zhenyuan Shen on 3/11/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation

/**
 *  This struct stores strings in Lean Cloud Backend.
 *
 *  - important: DO NOT modify this struct.
 */
struct LCConstants {
    
    /**
     *  General keys are used in every tables and every objects.
     *
     *  - important: DO NOT modify this struct.
     */
    struct GeneralKey {
        static let objectId = "objectId"
        static let updateAt = "updatedAt"
        static let createAt = "createdAt"
    }
    
    /**
     *  Keys used in "_User" table.
     *
     *  - important: DO NOT modify this struct.
     */
    struct UserKey {
        static let gender = "gender"
        static let avatarFile = "avatarFile"
        static let nickname = "nickname"
        static let phone = "mobilePhoneNumber"
        static let blockUserIdList = "blockUserIdList"
        static let nicknameNorm = "nicknameNorm"
        static let email = "email"
        static let accountType = "accountType"
        static let location = "geoPoint"
        static let username = "username"
        static let avatarURL = "avatarURL"
        static let followers = "followers"
        static let followees = "followees"
    }
    
    /**
     *  Keys used in "Person" table.
     *
     *  - important: DO NOT modify this struct.
     */
    struct PersonKey {
        static let className = "Person"
        
        static let name = "name"
        static let avatarFile = "avatarFile"
        static let infoFile = "infoFile"
        static let type = "type"
        static let start = "start"
        static let end = "end"
        static let dynasty = "dynasty"
        static let dynasty_detail = "dynasty_detail"
        static let pinyin = "pinyin"
        static let avatarURL = "avatarURL"
        static let infoURL = "infoURL"
    }
    
    /**
     *  Keys used in "Event" table.
     *
     *  - important: DO NOT modify this struct.
     */
    struct EventKey {
        static let className = "Event"
        
        static let name = "name"
        static let avatarFile = "avatarFile"
        static let infoFile = "infoFile"
        static let type = "type"
        static let start = "start"
        static let end = "end"
        static let dynasty = "dynasty"
        static let dynasty_detail = "dynasty_detail"
        static let pinyin = "pinyin"
        static let avatarURL = "avatarURL"
        static let infoURL = "infoURL"
    }
    
    /**
     *  Keys used in "_Followee" table.
     *
     *  - important: DO NOT modify this struct.
     */
    struct FolloweeKey {
        static let followee = "followee"
    }
    
    /**
     *  Keys used in "_Follower" table.
     *
     *  - important: DO NOT modify this struct.
     */
    struct FollowerKey {
        static let follower = "follower"
    }
}
