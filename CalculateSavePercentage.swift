//
//  CalculateSavePercentage.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-02-25.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation

class CalculateSavePercentage {
    
    func calculateSavePercentage(shots: Double, goals:Double) -> String {
        
        //http://stackoverflow.com/questions/42418695/how-to-remove-leading-zero-from-double-calculation/42418798#42418798
        
        var returnResult = ""
        
        let savePercentage = shots / (goals + shots)
        
        let formatter = NumberFormatter()
        formatter.maximumIntegerDigits = 0
        formatter.minimumFractionDigits = 3
        formatter.maximumFractionDigits = 3
        
        if savePercentage == 1.0 {
            
            returnResult = "1.000"
            
        } else if savePercentage < 1 {
            
            returnResult = formatter.string(from: NSNumber(value: savePercentage))!
            
        } else {
            
            returnResult = ".000"
        }
        
        return returnResult
        
    }
}

