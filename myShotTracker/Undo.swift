//
//  Undo.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-26.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UndoLastShot {
    
    //App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func lastShotOnNet(view: MainView, button: UIButton, managedContext:NSManagedObjectContext) {
        
        let formatShotGoalPercentageAttributedString = FormatShotGoalPercentageAttributedString()
        
        if button == view.leftUndoButton {
            
            if GlobalVariables.myShotArray.count >  0 {
                
                //Check to see if the last shot was a shot or goal.
                let lastShot = (GlobalVariables.myShotArray.last)?.result
                
                managedContext.delete((appDelegate.lastShot?.last!)!)
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("ViewController|updateCurrentGameWithShots: Fetch error: \(error) description: \(error.userInfo)")
                }
                
                //Delete last entry in shotArray
                GlobalVariables.myShotArray.removeLast()
                appDelegate.lastShot?.removeLast()
                
                view.leftHockeyNetImageView.layer.sublayers?.removeLast()
                
                GlobalVariables.myShotsOnNet -= 1
                
                let shotString = formatShotGoalPercentageAttributedString.formattedString(shots: GlobalVariables.myShotsOnNet, goals: GlobalVariables.myGoals, fontSize: 14)
                
                view.leftShotGoalPercentageLabel.attributedText = shotString
                
                if GlobalVariables.myShotsOnNet == 0 {
                    
                    view.leftUndoButton.isEnabled = false
                    view.leftShotDetailsButton.isEnabled = false
                    
                    let shotString = formatShotGoalPercentageAttributedString.formattedString(shots: GlobalVariables.myShotsOnNet, goals: GlobalVariables.myGoals, fontSize: 14)
                    view.leftShotGoalPercentageLabel.attributedText = shotString
                    
                }
                
                if lastShot == shotType.goal {
                    
                    GlobalVariables.myGoals -= 1
                    
                    let shotString = formatShotGoalPercentageAttributedString.formattedString(shots: GlobalVariables.myShotsOnNet, goals: GlobalVariables.myGoals, fontSize: 14)
                    view.leftShotGoalPercentageLabel.attributedText = shotString
                    
                }
                
            } // if
            
        } else if button == view.rightUndoButton {
            
            if GlobalVariables.theirShotArray.count >  0 {
                
                //Check to see if the last shot was a shot or goal.
                let lastShot = (GlobalVariables.theirShotArray.last)?.result
                
                //Delete last entry in shotArray
                GlobalVariables.theirShotArray.removeLast()
                
                view.rightHockeyNetImageView.layer.sublayers?.removeLast()
                
                GlobalVariables.theirShotsOnNet -= 1
                
                let shotString = formatShotGoalPercentageAttributedString.formattedString(shots: GlobalVariables.theirShotsOnNet, goals: GlobalVariables.theirGoals, fontSize: 14)
                
                view.rightShotGoalPercentageLabel.attributedText = shotString
                
                if GlobalVariables.theirShotsOnNet == 0 {
                    
                    view.rightUndoButton.isEnabled = false
                    view.rightShotDetailsButton.isEnabled = false
                    
                    let shotString = formatShotGoalPercentageAttributedString.formattedString(shots: GlobalVariables.theirShotsOnNet, goals: GlobalVariables.theirGoals, fontSize: 14)
                    view.leftShotGoalPercentageLabel.attributedText = shotString
                    
                }
                
                if lastShot == shotType.goal {
                    
                    GlobalVariables.theirGoals -= 1
                    
                    let shotString = formatShotGoalPercentageAttributedString.formattedString(shots: GlobalVariables.theirShotsOnNet, goals: GlobalVariables.theirGoals, fontSize: 14)
                    view.rightShotGoalPercentageLabel.attributedText = shotString
                    
                }
                
            } // if
            
        }
        
    } //lastShot
}
