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
    }
    
    struct Color {
        static let naviBarTint = UIColor(netHex: 0x522421)
        static let c1 = UIColor(netHex: 0x522421)
        static let c2 = UIColor(netHex: 0x8C5A2E)
        static let c3 = UIColor(netHex: 0xBF8641)
        static let c4 = UIColor(netHex: 0xB3B372)

    }
}
