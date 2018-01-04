//
//  DrawView.swift
//  TouchTracker
//
//  Created by EasonChan on 1/3/18.
//  Copyright © 2018 Eason Chan. All rights reserved.
//

import UIKit

class DrawView : UIView{
    //var currentLine: Line?
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    @IBInspectable var finishedLineColor: UIColor = UIColor.black{
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.black{
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        currentLines.removeAll()
        
        setNeedsDisplay()  
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let touch = touches.first!
        print(#function)
        
        //get location of the touch in view's coordinate system
        //let location = touch.location(in: self)
        
        //currentLine = Line(begin: location, end: location)
        for touch in touches{
            let location = touch.location(in: self)
            let newLine = Line(begin: location, end: location)
            
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        //let touch = touches.first!
        //let location = touch.location(in: self)
        
        //currentLine?.end = location
        for touch in touches{
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        //if var line = currentLine{
        //    let touch = touches.first!
        //    let location = touch.location(in: self)
        //    line.end = location
            
        //    finishedLines.append(line)
            
        //}
        for touch in touches{
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key]{
                line.end = touch.location(in: self)
                
                finishedLines.append(line)
                currentLines.removeValue(forKey: key)
            }
        }
        //currentLine = nil
        setNeedsDisplay()
    }
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        //path.lineWidth = 10
        path.lineWidth = lineThickness
        path.lineCapStyle = CGLineCap.round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        //draw finisehed lines in black
        //UIColor.black.setStroke()
        finishedLineColor.setStroke()
        for line in finishedLines{
            strokeLine(line: line)
        }
        
        //if let line = currentLine {
            //if there is a line currently being drawn, do it in red
        //    UIColor.red.setStroke()
        //    strokeLine(line: line)
        //}
        //UIColor.red.setStroke()
        //currentLineColor.setStroke()
        
        for (_, line) in currentLines{
            let angle = line.angle
            colorFromLineAngle(angle: angle).setStroke()
            strokeLine(line: line)
        }
    }
    func colorFromLineAngle (angle: Double) -> UIColor {
        return UIColor(hue: CGFloat(angle / 360), saturation: 1, brightness: 1, alpha: 1)
    }
}
