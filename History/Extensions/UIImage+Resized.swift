//
//  UIImage+Resized.swift
//  History
//
//  Created by 1 on 3/14/18.
//  Copyright © 2018 GSS. All rights reserved.
//

import UIKit

// https://stackoverflow.com/questions/29137488/how-do-i-resize-the-uiimage-to-reduce-upload-image-size
extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
