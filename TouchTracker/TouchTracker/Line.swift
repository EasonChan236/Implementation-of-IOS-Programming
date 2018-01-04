//
//  Line.swift
//  TouchTracker
//
//  Created by EasonChan on 1/3/18.
//  Copyright © 2018 Eason Chan. All rights reserved.
//

import Foundation
import CoreGraphics

struct Line {
    
    var begin = CGPoint.zero
    var end = CGPoint.zero
    
    var angle : Double {
        let diffY = end.y - begin.y
        let diffX = end.x - begin.x
        let angleInRadiants = Double (atan2(diffY, diffX))
        let angle = angleInRadiants * 360 / (2 * Double.pi)
        return angle < 0 ? angle + 360 : angle
    }
}
