//
//  LCManager.swift
//  History
//
//  Created by Zhenyuan Shen on 3/17/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import AVOSCloud

class LCManager {
    static let sharedInstance: LCManager = {
        return LCManager()
    }()
    
    
    func getFileData(file : AVFile, withBlock block : @escaping (URL?, Error?) -> Void) {
        file.download { (url, error) in
            block(url, error)
        }
    }
}
