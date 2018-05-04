//
//  State.swift
//  History
//
//  Created by Zhenyuan Shen on 4/30/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import CoreLocation

struct State {
    static var currentLocation: CLLocation?
    static var currentFollowTopics = Set<String>()
}
