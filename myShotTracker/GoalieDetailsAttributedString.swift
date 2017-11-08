//
//  GoalieDetailsAttributedString.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-24.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class GoalieDetailsAttributedString {
    
    let fontColour:UIColor = .darkGray
    
    func goalieDetailInformation(number: String, firstName:String, lastName: String) -> NSAttributedString {
        
        let firstNameAttributedString = NSMutableAttributedString(string: firstName)
        firstNameAttributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin), range: NSMakeRange(0, firstNameAttributedString.length))
        
        let lastNameAttributedString = NSMutableAttributedString(string: lastName)
        lastNameAttributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.heavy), range: NSMakeRange(0, lastNameAttributedString.length))
        
        let combination = NSMutableAttributedString()
        let spaceAttributedString = NSMutableAttributedString(string: " ")

        
        let poundAttributedString = NSMutableAttributedString(string: "#")
        poundAttributedString.addAttribute(NSAttributedStringKey.font,value: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin),range: NSMakeRange(0, poundAttributedString.length))
        poundAttributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: fontColour, range: NSMakeRange(0, poundAttributedString.length))
        
        let numberAttributedString = NSMutableAttributedString(string: number)
        numberAttributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin), range: NSMakeRange(0, numberAttributedString.length))
        
        
        //Connor Surette | #1
        combination.append(firstNameAttributedString)
        combination.append(spaceAttributedString)
        combination.append(lastNameAttributedString)
        combination.append(spaceAttributedString)
        combination.append(poundAttributedString)
        combination.append(numberAttributedString)
        
        return combination
        
    }
}

