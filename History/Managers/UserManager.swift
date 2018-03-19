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
        return AVUser.current != nil
    }
    
    func getUserId(user: AVUser) -> String? {
        return user.objectId
    }
    
    func getAccountType(user: AVUser) -> String? {
        return user.object(forKey: LCConstants.UserKey.accountType) as? String
    }
    
    func getAvatarFile(user: AVUser) -> AVFile? {
        return user.object(forKey: LCConstants.UserKey.avatarFile) as? AVFile
    }
    // TODO
}
