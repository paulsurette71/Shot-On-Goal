//
//  SaveHockeyNetAsImage.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-11-08.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class SaveHockeyNetAsImage {
    
    var goalieNetArray = [Data]()
    
    func saveAsPNG(hockeyNetImageView: UIImageView, period: String) {
        
        // http://nshipster.com/image-resizing/
        
        //Apply the CAShapeLayer to the UIImage
        UIGraphicsBeginImageContext(CGSize(width: hockeyNetImageView.frame.width, height: hockeyNetImageView.frame.height))
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        hockeyNetImageView.layer.render(in: context)
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        //Resize the image
        let size = (img.size).applying(CGAffineTransform(scaleX: 1.0, y: 1.0))
        //       let hasAlpha = false
        let scale: CGFloat = 1.0
        
        UIGraphicsBeginImageContextWithOptions((img.size), false, scale)
        
        img.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        
        let scaleImage = UIGraphicsGetImageFromCurrentImageContext()
        
        savePNGToFile(scaleImage: scaleImage, period: period)
        
        goalieNetArray.append(UIImagePNGRepresentation(scaleImage!)!)
        
        UIGraphicsEndImageContext()
        
        
    }  //saveAsPNG
    
    func savePNGToFile(scaleImage: UIImage?, period: String) {
        
        //Write to file just to make sure...
        if let image = scaleImage {
            if let data = UIImagePNGRepresentation(image) {
                
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let documentsDirectory = paths[0]
                
                let name = period + ".png"
                let filename = documentsDirectory.appendingPathComponent(name)
                print("filename \(filename)")
                
                try? data.write(to: filename)
                
            } //if let data
            
        } //if let image
    }
    
}  //SaveHockeyNetAsImage
