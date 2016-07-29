//
//  ClockView.swift
//  ClockVisuals
//
//  Created by Jacob Macdonald on 7/29/16.
//  Copyright © 2016 Pentagram. All rights reserved.
//

import Foundation
import UIKit

let π : CGFloat = CGFloat(M_PI)

@IBDesignable class ClockView : UIView {
    
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor.orangeColor()
    
    private let LEDs = 120
    private var sections: [[CGFloat]] = []
    
    override func drawRect(rect: CGRect) {
        print("hi")
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
        
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = 11
        let path = UIBezierPath(arcCenter: center,
                                radius: radius / 2 - arcWidth / 2,
                                startAngle: 0,
                                endAngle: 2 * π,
                                clockwise: true)
        path.lineWidth = arcWidth
        outlineColor.setStroke()
        path.stroke()
        
        
        for section in sections {
            let start = section[0]
            let length = section[1]
            let startAngle: CGFloat = (2 * π / CGFloat(LEDs) * CGFloat(start) + 3 * π / 2) % (2 * π)
            let endAngle: CGFloat = (2 * π / CGFloat(LEDs) * CGFloat(start + length) + 3 * π / 2) % (2 * π)
            let path = UIBezierPath(arcCenter: center,
                                    radius: radius / 2 - arcWidth / 2,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true)
            path.lineWidth = arcWidth
            //path.lineCap = kCALineCapRound
            counterColor.setStroke()
            path.stroke()
        }
    }
    
    func update(sections: [[CGFloat]]) {
        self.sections = sections
        setNeedsDisplay()
    }
}
