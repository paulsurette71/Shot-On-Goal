//
//  ShotsGoalAttrib.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-20.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class FormatShotGoalPercentageAttributedString {
    
    let calculateSavePercentage = CalculateSavePercentage()
    
    let fontColour:UIColor = .darkGray
    let fontName = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)
    
    func formattedString(shots: Int, goals: Int, fontSize: CGFloat) -> NSMutableAttributedString {
        
        let numberOfShotsAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: String(shots))
        numberOfShotsAttributedString.addAttribute(NSAttributedString.Key.font,value: UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold),range: NSMakeRange(0, numberOfShotsAttributedString.length))
        
        let numberOfGoalsAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: String(goals))
        numberOfGoalsAttributedString.addAttribute(NSAttributedString.Key.font,value: UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold),range: NSMakeRange(0, numberOfGoalsAttributedString.length))
        
        //Change goals in string to red.
        numberOfGoalsAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSMakeRange(0, numberOfGoalsAttributedString.length))
        
        let savePercentage = calculateSavePercentage.calculateSavePercentage(shots: Double(shots), goals: Double(goals))
        
        let savePercentageAttributedString = NSMutableAttributedString(string: savePercentage)
        savePercentageAttributedString.addAttribute(NSAttributedString.Key.font,value: UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.thin),range: NSMakeRange(0, savePercentageAttributedString.length))
                savePercentageAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: fontColour, range: NSMakeRange(0, savePercentageAttributedString.length))
        
        let combination = NSMutableAttributedString()
        let seperatorString = NSMutableAttributedString(string: "/")
        seperatorString.addAttribute(NSAttributedString.Key.font,value: UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold),range: NSMakeRange(0, seperatorString.length))
        
        let percentString = NSMutableAttributedString(string: "%")
        percentString.addAttribute(NSAttributedString.Key.font,value: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin),range: NSMakeRange(0, percentString.length))
        percentString.addAttribute(NSAttributedString.Key.foregroundColor, value: fontColour, range: NSMakeRange(0, percentString.length))
        
        let shotsString = NSMutableAttributedString(string: "Shots")
        shotsString.addAttribute(NSAttributedString.Key.font,value: UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.thin),range: NSMakeRange(0, shotsString.length))
        
        let goalsString = NSMutableAttributedString(string: "Goals")
        goalsString.addAttribute(NSAttributedString.Key.font,value: UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.thin),range: NSMakeRange(0, goalsString.length))
        
        let spaceString = NSMutableAttributedString(string: " ")
        
        combination.append(shotsString)
        combination.append(spaceString)
        combination.append(numberOfShotsAttributedString)
        combination.append(spaceString)
        combination.append(goalsString)
        combination.append(spaceString)
        combination.append(numberOfGoalsAttributedString)
        combination.append(spaceString)
        combination.append(savePercentageAttributedString)
        combination.append(percentString)
        
        return combination
    }
    
    func defaultGoalPercentage() -> NSAttributedString {
        
        let numberOfShotsAttributedString = NSMutableAttributedString(string: "0")
        let numberOfGoalsAttributedString = NSMutableAttributedString(string: "0")
        let savePercentage                = NSMutableAttributedString(string: ".000")
        let seperatorString               = NSMutableAttributedString(string: "|")
        let percentString                 = NSMutableAttributedString(string: "%")
        
        //Change goals in string to red.
        numberOfGoalsAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "hockeyNetRed")!, range: NSMakeRange(0, numberOfGoalsAttributedString.length))
        
        savePercentage.addAttribute(NSAttributedString.Key.font,value: fontName,range: NSMakeRange(0, savePercentage.length))
        savePercentage.addAttribute(NSAttributedString.Key.foregroundColor, value: fontColour, range: NSMakeRange(0, savePercentage.length))
        
        let combination = NSMutableAttributedString()
        
        seperatorString.addAttribute(NSAttributedString.Key.font,value: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold),range: NSMakeRange(0, seperatorString.length))
        
        
        percentString.addAttribute(NSAttributedString.Key.font,value: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin),range: NSMakeRange(0, percentString.length))
        percentString.addAttribute(NSAttributedString.Key.foregroundColor, value: fontColour, range: NSMakeRange(0, percentString.length))
        
        
        combination.append(numberOfShotsAttributedString)
        combination.append(seperatorString)
        combination.append(numberOfGoalsAttributedString)
        combination.append(seperatorString)
        combination.append(savePercentage)
        combination.append(percentString)
        
        return combination
        
    }
}
