//
//  GameDateAttribString.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-11-02.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class GameDateAttribString {
    
    let fontSize:CGFloat = 17
    
    func gameDateAtrib(curentDate: String, oppositionCity:String, oppositionTeamName: String) -> NSAttributedString {
        
        let dateAttributedString = NSMutableAttributedString(string: curentDate)
        dateAttributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.thin), range: NSMakeRange(0, dateAttributedString.length))
        
        let oppositionCityAttributedString = NSMutableAttributedString(string: oppositionCity)
        oppositionCityAttributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.heavy), range: NSMakeRange(0, oppositionCityAttributedString.length))
        
        let oppositionTeamNameAttributedString = NSMutableAttributedString(string: oppositionTeamName)
        oppositionTeamNameAttributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.heavy), range: NSMakeRange(0, oppositionTeamNameAttributedString.length))
        
        let combination = NSMutableAttributedString()
        let spaceAttributedString = NSMutableAttributedString(string: " ")
        
        let vsAttributedString = NSMutableAttributedString(string: "vs.")
        vsAttributedString.addAttribute(NSAttributedStringKey.font,value: UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.thin),range: NSMakeRange(0, vsAttributedString.length))
//        vsAttributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: fontColour, range: NSMakeRange(0, vsAttributedString.length))
        
        
        //Nov 1, 2017 vs. Guelph Gryphons
        combination.append(dateAttributedString)
        combination.append(spaceAttributedString)
        combination.append(vsAttributedString)
        combination.append(spaceAttributedString)
        combination.append(oppositionCityAttributedString)
        combination.append(spaceAttributedString)
        combination.append(oppositionTeamNameAttributedString)
        
        
        return combination
        
    }
    
}  //GameDateAttribString
