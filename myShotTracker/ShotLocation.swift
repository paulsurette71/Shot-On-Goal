//
//  ShotLocation.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-11-13.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class ShotLocation {
    
    let puck = CGFloat(10)
    
    func checkShotLocation(image:UIImageView, shot:CGPoint) -> CGPoint{
        
        var newShot = shot
        
        if shot.x < puck {
            
            newShot = CGPoint(x: puck, y: shot.y)
            
        }
        
        if shot.y < puck {
            
            newShot = CGPoint(x:shot.x , y: puck)
            
        }
        
        if shot.x > image.frame.width - puck{
            
            let newX = image.frame.width - puck
            newShot = CGPoint(x: newX, y: shot.y)
            
        }
        
        if shot.y > image.frame.height - puck{
            
            let newY = image.frame.height - puck
            newShot = CGPoint(x: shot.x, y: newY)
            
        }
        
        return newShot
        
    }  //checkShotLocation
    
}  //ShotLocation
