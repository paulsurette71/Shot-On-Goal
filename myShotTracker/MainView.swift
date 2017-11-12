//
//  MainView.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-27.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit
import CoreData

class MainView: UIView {
    
    //Last Shot
    var lastShotForUndo: ShotDetails?
    
    //UIButton
    @IBOutlet weak var leftGoalieButton: UIButton!
    @IBOutlet weak var leftShotDetailsButton: UIButton!
    @IBOutlet weak var leftPeriodButton: UIButton!
    @IBOutlet weak var leftUndoButton: UIButton!
    @IBOutlet weak var leftResetButton: UIButton!
    
    //Right UIButton
    @IBOutlet weak var rightGoalieButton: UIButton!
    @IBOutlet weak var rightShotDetailsButton: UIButton!
    @IBOutlet weak var rightPeriodButton: UIButton!
    @IBOutlet weak var rightUndoButton: UIButton!
    @IBOutlet weak var rightResetButton: UIButton!
    
    //UILabel
    @IBOutlet weak var leftGoalieNameInformationLabel: UILabel!
    @IBOutlet weak var leftShotGoalPercentageLabel: UILabel!
    @IBOutlet weak var rightGoalieNameInformationLabel: UILabel!
    @IBOutlet weak var rightShotGoalPercentageLabel: UILabel!
    @IBOutlet weak var leftTeamNameLabel: UILabel!
    @IBOutlet weak var rightTeamNameLabel: UILabel!
    
    //UIImageView
    @IBOutlet weak var leftGoalieHeadshotImageView: UIImageView!
    @IBOutlet weak var rightGoalieHeadShotImageView: UIImageView!
    @IBOutlet weak var leftHockeyNetImageView: UIImageView!
    @IBOutlet weak var rightHockeyNetImageView: UIImageView!
    
    //UITapGestureRecognizer
    @IBOutlet weak var tapGestureRecognizer: UITapGestureRecognizer!
    
    //Classes
    let undoLastShot                             = UndoLastShot()
    let goalieInformationPopover                 = GoalieInformationPopover()
    let shotDetailsPopover                       = ShotDetailsPopover()
    let periodPopover                            = PeriodPopover()
    let drawPuck                                 = DrawPuck()
    let formatShotGoalPercentageAttributedString = FormatShotGoalPercentageAttributedString()
    let resetAlert                               = ResetAlert()
    let updateGame                               = UpdateGame()
    
    //CoreData
    var managedContext: NSManagedObjectContext!
    
    //Period
    var selectedPeriod: Period!
    
    //App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Protocol
    var leftGoalieDelegate: storeLeftGoalieDelegate?
    var rightGoalieDelegate: storeRightGoalieDelegate?
    var leftGoalieIndex: storeLeftGoalieIndexPathDelegate?
    var rightGoalieIndex: storeRightGoalieIndexPathDelegate?
    var periodSelected: storeScoreClockDelegate?

    var lastShot:            storeLastShotsDelegate?
    
    //IBAction
    @IBAction func leftGoalie(_ sender: UIButton) {
        
        goalieInformationPopover.leftGoalieDelegate  = leftGoalieDelegate
        goalieInformationPopover.rightGoalieDelegate = rightGoalieDelegate
        goalieInformationPopover.leftGoalieIndex     = leftGoalieIndex
        goalieInformationPopover.rightGoalieIndex    = rightGoalieIndex
        
        goalieInformationPopover.showGoalieInformation(view: self, managedContext: managedContext, sender: sender)
        
    }
    
    @IBAction func rightGoalie(_ sender: UIButton) {
        
        goalieInformationPopover.leftGoalieDelegate  = leftGoalieDelegate
        goalieInformationPopover.rightGoalieDelegate = rightGoalieDelegate
        goalieInformationPopover.leftGoalieIndex     = leftGoalieIndex
        goalieInformationPopover.rightGoalieIndex    = rightGoalieIndex
        
        goalieInformationPopover.showGoalieInformation(view: self, managedContext: managedContext, sender: sender)
    }
    
    
    @IBAction func leftShotDetails(_ sender: UIButton) {
        
        shotDetailsPopover.showShotDetails(view: self, sender: sender)
    }
    
    @IBAction func rightShotDetails(_ sender: UIButton) {
        
        shotDetailsPopover.showShotDetails(view: self, sender: sender)
        
    }
    
    @IBAction func leftPeriod(_ sender: UIButton) {
        
        periodPopover.periodSelected = periodSelected
        periodPopover.mainView = self
        
        periodPopover.showPeriodPopover(view: self, selectedPeriod: selectedPeriod, sender: sender)
        
    }
    
    @IBAction func rightPeriod(_ sender: UIButton) {
        
        periodPopover.periodSelected = periodSelected
        periodPopover.mainView = self
        
        periodPopover.showPeriodPopover(view: self, selectedPeriod: selectedPeriod, sender: sender)
    }
    
    
    @IBAction func leftUndo(_ sender: UIButton) {
        
        
        undoLastShot.lastShotOnNet(view: self, button: sender, managedContext: managedContext)
        
    }
    
    @IBAction func rightUndo(_ sender: UIButton) {
        
        undoLastShot.lastShotOnNet(view: self, button: sender, managedContext: managedContext)
    }
    
    
    @IBAction func leftReset(_ sender: UIButton) {
        
        resetAlert.showAlert(mainView: self)
        
    }
    
    @IBAction func rightReset(_ sender: Any) {
        
        resetAlert.showAlert(mainView: self)
        
    }
    
    @objc func leftShotOnNet(_ shot: UITapGestureRecognizer) {
        
        if !leftUndoButton.isEnabled {
            leftUndoButton.isEnabled = true
            leftShotDetailsButton.isEnabled = true
        }
        
        GlobalVariables.myShotsOnNet += 1
        
        let shot = shot.location(ofTouch: 0, in: leftHockeyNetImageView)
        drawPuck.drawPuck(shot: shot, puckColour: UIColor.black.cgColor, puckSize: 10, imageView: leftHockeyNetImageView, shotNumber: String(GlobalVariables.myShotsOnNet))
        
        let timeDifference = calculateDifferenceInTime(array: GlobalVariables.myShotArray)
        
        let shotString = formatShotGoalPercentageAttributedString.formattedString(shots: GlobalVariables.myShotsOnNet, goals: GlobalVariables.myGoals,fontSize: 14)
        
        leftShotGoalPercentageLabel.attributedText = shotString
        
        let shotInfo = ShotInfo(shotNumber: GlobalVariables.myShotsOnNet, location: shot, timeOfShot: Date(), timeDifference: timeDifference, period: selectedPeriod , result: .shot)
        
        GlobalVariables.myShotArray.append(shotInfo)
        
        //Pass Delegates
        updateGame.lastShot = lastShot

        updateGame.withCurrentShots(managedContext: managedContext, currentGame: appDelegate.currentGame!, goalie: appDelegate.leftGoalie!, shotArray: GlobalVariables.myShotArray)
        
    }
    
    func calculateDifferenceInTime(array: [ShotInfo]) -> TimeInterval {
        
        //Make sure there is at least 1 object in the array before continuing.
        guard array.count > 0 else {
            
            return 0
        }
        
        let previousShotDate = array.last?.timeOfShot
        let lastShotDate     = Date()
        let timeDifference   = lastShotDate.timeIntervalSince(previousShotDate!)
        
        return timeDifference
    }
    
    
    @objc func rightShotOnNet(_ shot: UITapGestureRecognizer) {
        
        if !rightUndoButton.isEnabled {
            rightUndoButton.isEnabled = true
            rightShotDetailsButton.isEnabled = true
        }
        
        GlobalVariables.theirShotsOnNet += 1
        
        let shot = shot.location(ofTouch: 0, in: rightHockeyNetImageView)
        drawPuck.drawPuck(shot: shot, puckColour: UIColor.black.cgColor, puckSize: 10, imageView: rightHockeyNetImageView, shotNumber: String(GlobalVariables.theirShotsOnNet))
        
        let timeDifference = calculateDifferenceInTime(array: GlobalVariables.theirShotArray)
        
        let shotString = formatShotGoalPercentageAttributedString.formattedString(shots: GlobalVariables.theirShotsOnNet, goals: GlobalVariables.theirGoals, fontSize: 14)
        rightShotGoalPercentageLabel.attributedText = shotString
        
        let shotInfo = ShotInfo(shotNumber: GlobalVariables.theirShotsOnNet, location: shot, timeOfShot: Date(), timeDifference: timeDifference, period: selectedPeriod , result: .shot)
        
        GlobalVariables.theirShotArray.append(shotInfo)
        
        //Pass Delegates
        updateGame.lastShot = lastShot

        updateGame.withCurrentShots(managedContext: managedContext, currentGame: appDelegate.currentGame!, goalie: appDelegate.rightGoalie!, shotArray: GlobalVariables.theirShotArray)
        
    }
    
    @objc func leftGoalOnNet(_ sender: UITapGestureRecognizer) {
        
        if !leftUndoButton.isEnabled {
            leftUndoButton.isEnabled = true
            leftShotDetailsButton.isEnabled = true
        }
        
        if sender.state == .ended {
            
            let goal = sender.location(ofTouch: 0, in: leftHockeyNetImageView)
            
            GlobalVariables.myShotsOnNet += 1
            GlobalVariables.myGoals += 1
            
            drawPuck.drawPuck(shot: goal, puckColour: UIColor.red.cgColor, puckSize: 10, imageView: leftHockeyNetImageView, shotNumber: String(GlobalVariables.myShotsOnNet))
            
            let timeDifference = calculateDifferenceInTime(array: GlobalVariables.myShotArray)
            
            let shotString = formatShotGoalPercentageAttributedString.formattedString(shots: GlobalVariables.myShotsOnNet, goals: GlobalVariables.myGoals, fontSize: 14)
            leftShotGoalPercentageLabel.attributedText = shotString
            
            let shotInfo = ShotInfo(shotNumber: GlobalVariables.myShotsOnNet, location: goal, timeOfShot: Date(), timeDifference: timeDifference, period: selectedPeriod , result: .goal)
            
            GlobalVariables.myShotArray.append(shotInfo)
            
            //Pass Delegates
            updateGame.lastShot = lastShot
            
            updateGame.withCurrentShots(managedContext: managedContext, currentGame: appDelegate.currentGame!, goalie: appDelegate.leftGoalie!, shotArray: GlobalVariables.myShotArray)
            
        }
    }
    
    @objc func rightGoalOnNet(_ sender: UITapGestureRecognizer) {
        
        if !rightUndoButton.isEnabled {
            rightUndoButton.isEnabled = true
            rightShotDetailsButton.isEnabled = true
        }
        
        if sender.state == .ended {
            
            let goal = sender.location(ofTouch: 0, in: rightHockeyNetImageView)
            
            GlobalVariables.theirShotsOnNet += 1
            GlobalVariables.theirGoals += 1
            
            drawPuck.drawPuck(shot: goal, puckColour: UIColor.red.cgColor, puckSize: 10, imageView: rightHockeyNetImageView, shotNumber: String(GlobalVariables.theirShotsOnNet))
            
            let timeDifference = calculateDifferenceInTime(array: GlobalVariables.theirShotArray)
            
            let shotString = formatShotGoalPercentageAttributedString.formattedString(shots: GlobalVariables.theirShotsOnNet, goals: GlobalVariables.theirGoals, fontSize: 14)
            rightShotGoalPercentageLabel.attributedText = shotString
            
            let shotInfo = ShotInfo(shotNumber: GlobalVariables.theirShotsOnNet, location: goal, timeOfShot: Date(), timeDifference: timeDifference, period: selectedPeriod , result: .goal)
            
            GlobalVariables.theirShotArray.append(shotInfo)
            
            //Pass Delegates
            updateGame.lastShot = lastShot
            
            updateGame.withCurrentShots(managedContext: managedContext, currentGame: appDelegate.currentGame!, goalie: appDelegate.rightGoalie!, shotArray: GlobalVariables.theirShotArray)
            
        }
    }
}
