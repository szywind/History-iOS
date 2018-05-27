//
//  String+URL.swift
//  History
//
//  Created by 1 on 5/25/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func getUIImage() -> UIImage {
        let url = URL(string: self.convertToHttps())
        if let data = try? Data(contentsOf: url!) {
            return UIImage(data: data)!
        } else {
            return UIImage(named: Constants.Default.defaultAvatar)!
        }
    }
    
    func getText() -> String {
        let url = URL(string: self.convertToHttps())
        if let data = try? Data(contentsOf: url!) {
            return NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
        } else {
            return Constants.Default.defaultInfo
        }
    }
}
