//
//  NumberImageBuilder.swift
//  History
//
//  Created by Zhenyuan Shen on 4/28/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

struct NumberImageBuilder {
    static func imageWith(count: Int) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = UIColor.white
        nameLabel.textColor = self.colorWith(count: count)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        let countStr = stringWith(count: count)
        
        nameLabel.text = countStr
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
    
    static func colorWith(count: Int) -> UIColor? {
        if count >= 10000 {
            return UIColor.red
        } else if count >= 5000 {
            return UIColor.orange
        } else if count >= 1000 {
            return UIColor.yellow
        } else if count >= 500 {
            return UIColor.green
        } else if count >= 100 {
            return UIColor.blue
        } else if count >= 50 {
            return UIColor.purple
        } else {
            return UIColor.brown
        }
    }
    
    static func stringWith(count: Int) -> String? {
        if count > 10000 {
            return "9999+"
        } else {
            return String(count)
        }
    }
}
