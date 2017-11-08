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
    let drawPuckScaled          = DrawPuckScaled()
    let calculateSavePercentage = CalculateSavePercentage()
    
    func gatherData(shotInformation:[Any], periodInformation:[Any]) -> [Data] {
        
        for periods in periodInformation {
            
            var shotCount = 0
            var goalCount = 0
            
            let hockeyNetImageView   = UIImageView(frame: CGRect(x: 0, y: 0, width: 500, height: 295))
            hockeyNetImageView.image = UIImage(named: "hocketNet")
            
            let period = (periods as AnyObject).value(forKey: "shotPeriod") as! String
            
            for shots in shotInformation {
                
                let shotOrGoal = ((shots as AnyObject).value(forKey: "shotType")) as! String
                let shotPeriod = ((shots as AnyObject).value(forKey: "shotPeriod")) as! String
                
                if period == shotPeriod {
                    
                    if shotOrGoal == "shot" {
                        
                        shotCount += 1
                        
                        drawPuckScaled.drawPuck(location: (shots as AnyObject).value(forKey: "shotLocation")! as! CGPoint, view: hockeyNetImageView, colour: UIColor.black.cgColor, shotNumber: String(shotCount))
                        
                    } else {
                        
                        goalCount += 1
                        
                        drawPuckScaled.drawPuck(location: (shots as AnyObject).value(forKey: "shotLocation")! as! CGPoint, view: hockeyNetImageView, colour: UIColor.red.cgColor, shotNumber: String(shotCount))
                        
                    } //else
                } //if period
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
            
            //create array of dictionaries that carr the shot and goal totals.
            shotDictionary = ["period": period, "shot": shotCount, "goal": goalCount]
            shotArray.append(shotDictionary)
            
            UIGraphicsEndImageContext()
            
            /*
             
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
             
             */
            
        } //for periods
        
        return goalieNetArray
        
    } //gatherData
    
//    func buildMessage(goalie:GoalieInformation, dateStringForTitle:String, goalieNetArray:[Data]) -> [Any] {
        func buildMessage(goalie:GoalieInformation, dateStringForTitle:NSAttributedString, goalieNetArray:[Data]) -> [Any] {

        //let goalieNumber = String((goalie.number)!)!
        let goalieNumber = String(describing: goalie.number!)
        
        let goalieName   = goalieNumber + "|" + (goalie.firstName)! + " " + (goalie.lastName)!
        
       var message = ""
//            var message:NSAttributedString? = nil
            var shotTotal = 0
        var goalTotal = 0
        
        //Build message
        message += "\n \n"
//        message = dateStringForTitle
        message += "\n \n"
        message += goalieName
        message += "\n \n"
        
        for periodInfo in shotArray {
                        
            message += (periodInfo as AnyObject).value(forKey: "period") as! String
            message += "\n"
            
            let shots = (periodInfo as AnyObject).value(forKey: "shot") as! Int
            let goals = (periodInfo as AnyObject).value(forKey: "goal") as! Int
            
            message += "Shots " + String(describing: shots + goals)
            message += "\n"
            message += "Goals " + String(describing:(periodInfo as AnyObject).value(forKey: "goal")!)
            message += "\n \n"
            
            shotTotal += (periodInfo as AnyObject).value(forKey: "shot") as! Int
            goalTotal += (periodInfo as AnyObject).value(forKey: "goal") as! Int
            
        }
        
        message += "Totals"
        message += "\n"
        message += "Shots " + String(shotTotal + goalTotal)
        message += "\n"
        message += "Goals " + String(goalTotal)
        message += "\n"
        message += "Save % " + calculateSavePercentage.calculateSavePercentage(shots: Double(shotTotal) , goals: Double(goalTotal) )
        message += "\n \n"
        message += "twitter: @ShotOnGoal47" 
        
        messageArray.append(message)
        
        for images in goalieNetArray {
            
            messageArray.append(images)
            
        }
        
        return messageArray
    }
    
    
    
    
} //class

