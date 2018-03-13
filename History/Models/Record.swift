//
//  Record.swift
//  History
//
//  Created by Zhenyuan Shen on 3/13/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

struct Record{
    
    var name: String?
    var avatar: UIImage?
    
    init(name: String?, avatar: UIImage?) {
        self.name = name
        self.avatar = avatar
    }
}
