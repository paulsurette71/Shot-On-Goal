//
//  DrawPuckScaled.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-03-17.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class DrawPuckScaled {
    
    //App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func drawPuck(location:CGPoint, view: UIImageView, colour: CGColor, shotNumber: String) {
        
        let hockeyPuckBezierPath = UIBezierPath(arcCenter: CGPoint(x: location.x,y: location.y), radius: 10.0, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = hockeyPuckBezierPath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = colour
        
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.white.cgColor
        
        
        //you can change the line width
        shapeLayer.lineWidth = 0.5
        
        let width  = view.frame.width / self.appDelegate.mainImageWidth
        let height = view.frame.height / self.appDelegate.mainImageHeight
        
        shapeLayer.transform = CATransform3DMakeScale(width, height, 1.0)
        
        view.layer.addSublayer(shapeLayer)
        
        let labelSize:CGFloat = 18
        
        //Add shot number
        // Attributed string
        let myAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: .thin) ,
//            NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Thin", size: 12.0)! ,
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        let myAttributedString = NSAttributedString(string: shotNumber, attributes: myAttributes )
        
        // Text layer
        let myTextLayer           = CATextLayer()
        myTextLayer.string        = myAttributedString
        
        //y = left <-> right
        //x = up <-> down
        
        myTextLayer.frame         = CGRect(x: location.x - (labelSize / 2) , y: location.y - (labelSize / 2) + 1.5 , width: labelSize, height: labelSize)
        myTextLayer.alignmentMode = kCAAlignmentCenter
        myTextLayer.contentsScale = UIScreen.main.scale
//        myTextLayer.backgroundColor = UIColor.blue.cgColor  //testing
        
//        myTextLayer.transform = CATransform3DMakeScale(width, height, 0.0)
        
        shapeLayer.addSublayer(myTextLayer)
        //view.layer.addSublayer(myTextLayer)
        
    } //drawPuck
}

//0.00357800722122192
//0.00354999303817749

