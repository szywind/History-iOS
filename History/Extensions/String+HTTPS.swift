//
//  String+HTTPS.swift
//  History
//
//  Created by Zhenyuan Shen on 3/18/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation

extension String {
    func convertToHttps() -> String {
        let index = self.index(of: ":") ?? self.endIndex
        if index == self.endIndex {
            return "https://" + self
        } else if self.hasPrefix("https") {
            return self
        } else {
            return "https" + self[index...]
        }
    }
}
