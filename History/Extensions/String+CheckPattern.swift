//
//  String+CheckPattern.swift
//  History
//
//  Created by Zhenyuan Shen on 4/22/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation

extension String {
    // https://blog.csdn.net/liu_esther/article/details/51578762
    func isValidateMobile() -> Bool {
//        let mobile = self.replacingOccurrences(of: " ", with: "")
        let mobile = self
        if (mobile.count != 11) {
            return false
        }
        // 移动号段正则表达式
        let cmNumReg = "^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$"
        // 联通号段正则表达式
        let cuNumReg = "^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$"
        // 电信号段正则表达式
        let ctNumReg = "^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$"
        
        let pred1 = NSPredicate(format: "SELF MATCHES %@", cmNumReg)
        let isMatch1 = pred1.evaluate(with: mobile)
        
        let pred2 = NSPredicate(format: "SELF MATCHES %@", cuNumReg)
        let isMatch2 = pred2.evaluate(with: mobile)
        
        let pred3 = NSPredicate(format: "SELF MATCHES %@", ctNumReg)
        let isMatch3 = pred3.evaluate(with: mobile)
        
        return isMatch1 || isMatch2 || isMatch3
    }
    
    // http://emailregex.com/
    // https://www.cnblogs.com/hellocby/archive/2012/12/05/2803094.html
    // http://brainwashinc.com/2017/08/18/ios-swift-3-validate-email-password-format/
    func isValidateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
