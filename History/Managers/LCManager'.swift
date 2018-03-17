//
//  LCManager'.swift
//  History
//
//  Created by Zhenyuan Shen on 3/17/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import Foundation
import LeanCloudSocial

class LCManager {
    static let sharedInstance: LCManager = {
        return LCManager()
    }()


    func getFileData(file : AVFile, withBlock block : @escaping (_ data : NSData) -> Void) {
        file.getDataInBackground({ (data, error) in
            if error == nil {
                block(data! as NSData)
            } else {
                print(error?.localizedDescription)
            }
        })
    }
}
