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
        static let nickname = "nickName"
        static let phone = "phone"
        static let blockUserIdList = "blockUserIdList"
        static let nicknameNorm = "nicknameNorm"
        static let email = "email"
        static let accountType = "accountType"
        static let location = "geoPoint"
    }
    
    /**
     *  Keys used in "People" table.
     *
     *  - important: DO NOT modify this struct.
     */
    struct PeopleKey {
        static let name = "name"
        static let avatarFile = "avatarFile"
        static let infoFile = "infoFile"
    }
    

}

