//
//  UserManager.swift
//  History
//
//  Created by Zhenyuan Shen on 3/11/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import LeanCloud
import LeanCloudSocial
class UserManager {
    static let sharedInstance: UserManager = {
        return UserManager()
    }()
    
    private init(){}
    
    func currentUser() -> LCUser {
        return LCUser.current!
    }
    
    func isLogin() -> Bool {
        return LCUser.current != nil
    }
}
