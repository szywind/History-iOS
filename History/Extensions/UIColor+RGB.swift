//
//  UIColor+RGB.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    convenience init(netHex:Int) {
        self.init(red: CGFloat((netHex >> 16) & 0xff), green: CGFloat((netHex >> 8) & 0xff), blue: CGFloat(netHex & 0xff))
    }
}

