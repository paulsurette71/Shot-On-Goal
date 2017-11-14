//
//  HasThereBeenOneShot.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-11-14.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation

class HasThereBeenOneShot {
    
    func firstShotOnNet() -> Bool{
        
        //http://stackoverflow.com/questions/9964371/how-to-detect-first-time-app-launch-on-an-iphone
        
        let defaults = UserDefaults.standard
        
        //for testing
        //defaults.removeObject(forKey: "firstShotOnNet")
        
        if defaults.string(forKey: "firstShotOnNet") != nil {
            
            //already have one shot.
            
            return true
            
        } else {
            
            //no shots recorded
            
            defaults.set(true, forKey: "firstShotOnNet")
            
            return false
        }
    }
} //class IsAppAlreadyLaunchedOnce

