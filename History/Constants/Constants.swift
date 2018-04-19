//
//  Constants.swift
//  History
//
//  Created by Zhenyuan Shen on 3/11/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct Default {
        static let defaultInfo = "不详"
        static let defaultAvatar = "default"
        static let defaultUsernameLimit = 20
        static let defaultSmsCodeLength = 6
        static let defaultPasswordLimit = 10
    }
    
    struct CoreData {
        static let eventTypeFilterFormat = "type == %@"
        static let eventIdFilterFormat = "objectId == %@"
        static let personIdFilterFormat = "objectId == %@"
    }
    
    struct Notification {
        static let fetchDataFromLC = "didFetchDataNotification"
        static let refreshUI = "refreshUI"
        static let toggleSideMenu = "toggleSideMenu"
        static let emailRegister = "emailRegister"
        static let phoneRegister = "phoneRegister"
    }
    
    struct Color {
        static let c1: Int = 0x522421
        static let c2: Int = 0x8C5A2E
        static let c3: Int = 0xBF8641
        static let c4: Int = 0xB3B372
        static let naviBarTint = UIColor(netHex: c1)
        static let bgColor = UIColor(netHex: c3, alpha: 0.8)
        static let coral = UIColor(red: 244, green: 111, blue: 96)
    }
    
    struct Constraint {
        static let sideMenuWidth: CGFloat = 280.0
    }
}
