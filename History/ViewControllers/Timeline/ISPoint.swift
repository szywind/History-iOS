//
//  ISPoint.swift
//  ISTimeline
//
//  Created by Max Holzleitner on 13.05.16.
//  Copyright © 2016 instant:solutions. All rights reserved.
//

import UIKit

open class ISPoint {
    
    open var title:String
    open var description:String?
    open var pointColor:UIColor
    open var lineColor:UIColor
    open var touchUpInside:Optional<(_ point:ISPoint) -> Void>
    open var fill:Bool
    open var isRight:Bool
    
    public init(title:String, description:String, pointColor:UIColor, lineColor:UIColor, touchUpInside:Optional<(_ point:ISPoint) -> Void>, fill:Bool, isRight:Bool) {
        self.title = title
        self.description = description
        self.pointColor = pointColor
        self.lineColor = lineColor
        self.touchUpInside = touchUpInside
        self.fill = fill
        self.isRight = isRight
    }
    
    public convenience init(title:String, description:String, pointColor:UIColor, lineColor:UIColor, touchUpInside:Optional<(_ point:ISPoint) -> Void>, fill:Bool) {
        let defaultIsRight = true
        self.init(title: title, description: description, pointColor: pointColor, lineColor: lineColor, touchUpInside: touchUpInside, fill: fill, isRight: defaultIsRight)
    }
    
    public convenience init(title:String, description:String, touchUpInside:Optional<(_ point:ISPoint) -> Void>) {
        let defaultColor = UIColor.init(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
        self.init(title: title, description: description, pointColor: defaultColor, lineColor: defaultColor, touchUpInside: touchUpInside, fill: false, isRight: true)
    }
    
    public convenience init(title:String, touchUpInside:Optional<(_ point:ISPoint) -> Void>) {
        self.init(title: title, description: "", touchUpInside: touchUpInside)
    }
    
    public convenience init(title:String) {
        self.init(title: title, touchUpInside: nil)
    }
}
