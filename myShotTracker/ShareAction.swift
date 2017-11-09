//
//  ShareAction.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-03-17.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class ShareAction {
    
    var shotCount = 0
    var goalCount = 0
    
    var goalieNetArray = [Data]()
    var shotDictionary = [String:Any]()
    var shotArray      = [Any]()
    var messageArray   = [Any]()
    
    //classes
    let drawPuckScaled                           = DrawPuckScaled()
    let calculateSavePercentage                  = CalculateSavePercentage()
    let goalieDetailsAttributedString            = GoalieDetailsAttributedString()
    let gameDateAttribString                     = GameDateAttribString()
    let formatShotGoalPercentageAttributedString = FormatShotGoalPercentageAttributedString()
    
    func gatherData(shotInformation:[Any]) -> [Data] {
        
        messageArray = []
        
        var shotCount = 0
        var goalCount = 0
        
        let hockeyNetImageView   = UIImageView(frame: CGRect(x: 0, y: 0, width: 500, height: 295))
        hockeyNetImageView.image = UIImage(named: "hocketNet")
        
        for shots in shotInformation {
            
            let shotOrGoal = ((shots as AnyObject).value(forKey: "shotType")) as! String
            
            if shotOrGoal == "shot" {
                
                shotCount += 1
                
                drawPuckScaled.drawPuck(location: (shots as AnyObject).value(forKey: "shotLocation")! as! CGPoint, view: hockeyNetImageView, colour: UIColor.black.cgColor, shotNumber: String(shotCount))
                
            } else {
                
                goalCount += 1
                shotCount += 1
                
                drawPuckScaled.drawPuck(location: (shots as AnyObject).value(forKey: "shotLocation")! as! CGPoint, view: hockeyNetImageView, colour: UIColor.red.cgColor, shotNumber: String(shotCount))
                
            } //else
            
        } //for shots
        
        //Apply the CAShapeLayer to the UIImage
        UIGraphicsBeginImageContext(CGSize(width: hockeyNetImageView.frame.width, height: hockeyNetImageView.frame.height))
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        hockeyNetImageView.layer.render(in: context)
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        //Resize the image
        let size = (img.size).applying(CGAffineTransform(scaleX: 1.0, y: 1.0))
        let hasAlpha = true
        let scale: CGFloat = 1.0
        
        UIGraphicsBeginImageContextWithOptions((img.size), !hasAlpha, scale)
        img.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        
        let scaleImage = UIGraphicsGetImageFromCurrentImageContext()
        
        goalieNetArray.append(UIImagePNGRepresentation(scaleImage!)!)
        
        //            //create array of dictionaries that carr the shot and goal totals.
        //            shotDictionary = ["period": period, "shot": shotCount, "goal": goalCount]
        //            shotArray.append(shotDictionary)
        
        UIGraphicsEndImageContext()
        
        //            //Write to file just to make sure...
        //            if let image = scaleImage {
        //                if let data = UIImagePNGRepresentation(image) {
        //
        //                    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //                    let documentsDirectory = paths[0]
        //
        //                    let name = period + ".png"
        //                    let filename = documentsDirectory.appendingPathComponent(name)
        //                    print("filename \(filename)")
        //
        //                    try? data.write(to: filename)
        //                } //if let data
        //            } //if let image
        
        //        } //for periods
        
        return goalieNetArray
        
    } //gatherData
    
    
    func buildMessage(goalie:GoalieInformation, dateStringForTitle:NSAttributedString, goalieNetArray:[Data], shotInformation: [Any],  periodInformation:[Any]) -> [Any] {
        
        let currentGoalie = goalieDetailsAttributedString.goalieDetailInformation(number: goalie.number!, firstName: goalie.firstName!, lastName: goalie.lastName!)
        
        let currentTeam = NSMutableAttributedString(string: goalie.city! + " " + goalie.teamName!)
        currentTeam.addAttribute(NSAttributedStringKey.font,value: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.heavy),range: NSMakeRange(0, currentTeam.length))
        
        
        let combination = NSMutableAttributedString()
        let shotDetails = NSMutableAttributedString()
        
        let newLineAttributedString = NSMutableAttributedString(string: "\n")
        
        var shotTotal = 0
        var goalTotal = 0
        
        combination.append(currentGoalie)
        combination.append(newLineAttributedString)
        combination.append(currentTeam)
        combination.append(newLineAttributedString)
        combination.append(newLineAttributedString)
        combination.append(dateStringForTitle)
        combination.append(newLineAttributedString)
        
        var dateArray = [Date]()
        
        print("periodInformation \(periodInformation)")
        
        var storedPeriod = ""
        
        for shots in shotInformation {
            
            let currentPeriod     = ((shots as AnyObject).value(forKey: "shotPeriod")) as! String
            
            if currentPeriod != storedPeriod {
                
                let currentPeriodAttributedString = NSMutableAttributedString(string:("\(currentPeriod)"))
                currentPeriodAttributedString.addAttribute(NSAttributedStringKey.font,value: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.heavy),range: NSMakeRange(0, currentPeriodAttributedString.length))
                shotDetails.append(currentPeriodAttributedString)
                shotDetails.append(newLineAttributedString)
                shotDetails.append(newLineAttributedString)
                
                storedPeriod = currentPeriod
            }
            
            let shotOrGoal        = ((shots as AnyObject).value(forKey: "shotType")) as! String
            let currentTime       = ((shots as AnyObject).value(forKey: "shotDate")) as! Date
            let prettyTime        = convertDate(date: currentTime as NSDate)
            //            let currentPeriod     = ((shots as AnyObject).value(forKey: "shotPeriod")) as! String
            let currentShotNumber = ((shots as AnyObject).value(forKey: "shotNumber")) as! Int
            
            dateArray.append(currentTime)
            let timeDif = calculateDifferenceInTime(array: dateArray)
            
            let currentTeam = NSMutableAttributedString(string:("Shot #\(String(currentShotNumber)) \(prettyTime) \(shotOrGoal) \(timeDif.stringTime)"))
            shotDetails.append(currentTeam)
            shotDetails.append(newLineAttributedString)
            
            if shotOrGoal == "shot" {
                
                shotTotal += 1
                
            } else {
                
                goalTotal += 1
                shotTotal += 1
                
            } //else
            
        } //for shots
        
        let shotTotals = formatShotGoalPercentageAttributedString.formattedString(shots: shotTotal, goals: goalTotal, fontSize: 17)
        
        shotDetails.addAttribute(NSAttributedStringKey.font,value: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular),range: NSMakeRange(0, shotDetails.length))
        
        combination.append(shotTotals)
        combination.append(newLineAttributedString)
        
        messageArray.insert(combination, at: 0)
        messageArray.insert(goalieNetArray[0], at: 1)
        messageArray.insert(shotDetails, at: 2)
        
        return messageArray
    }
    
    func convertDate(date:NSDate) -> String {
        
        let formatter = DateFormatter()
        
        formatter.timeStyle = DateFormatter.Style.medium
        
        return formatter.string(from: date as Date)
    }
    
    func calculateDifferenceInTime(array: [Date]) -> TimeInterval {
        
        //Make sure there is at least 1 object in the array before continuing.
        guard array.count > 1 else {
            
            return 0
        }
        
        let previousShotDate = array[array.count - 2]
        let lastShotDate     = array[array.count - 1]
        let timeDifference   = lastShotDate.timeIntervalSince(previousShotDate)
        
        return timeDifference
    }
    
} //class

