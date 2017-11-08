//
//  DrawPuck.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-02-23.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class DrawPuck {
    
    func drawPuck(shot: CGPoint, puckColour: CGColor, puckSize: CGFloat, imageView: UIImageView, shotNumber: String) {
        
        let hockeyPuckBezierPath = UIBezierPath(arcCenter: CGPoint(x: shot.x,y: shot.y), radius: CGFloat(puckSize), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        
        //give the layer a name
        shapeLayer.name = "puck"
        
        shapeLayer.path = hockeyPuckBezierPath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = puckColour
        
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.white.cgColor
        
        //you can change the line width
        shapeLayer.lineWidth = 0.5
        
        let labelSize:CGFloat = 18
        
        /*
         
         //create label
         var label = UILabel()
         
         label = UILabel(frame: CGRect(x: shot.x - labelSize / 2  , y: shot.y - labelSize / 2  , width: labelSize, height: labelSize))
         label.font          = UIFont(name: "HelveticaNeue-Thin", size: 12.0)
         label.text          = shotNumber
         label.textColor     = UIColor.white
         label.textAlignment = .center
         
         imageView.layer.addSublayer(shapeLayer)
         imageView.addSubview(label)
         
         */
        
        
        // Attributed string
        let myAttributes = [
//            NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Thin", size: 12.0)! ,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: .thin) ,
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        let myAttributedString = NSAttributedString(string: shotNumber, attributes: myAttributes )
        
        // Text layer
        let myTextLayer           = CATextLayer()
        myTextLayer.string        = myAttributedString
        
        //y = left <-> right
        //x = up <-> down
        
        myTextLayer.frame         = CGRect(x: shot.x - (labelSize / 2) , y: shot.y - (labelSize / 2) + 1.5 , width: labelSize, height: labelSize)
        myTextLayer.alignmentMode = kCAAlignmentCenter
        myTextLayer.contentsScale = UIScreen.main.scale
        
        imageView.layer.addSublayer(shapeLayer)
        shapeLayer.addSublayer(myTextLayer)
        
        //imageView.layer.addSublayer(myTextLayer)
        
    } //func drawPuck
}
