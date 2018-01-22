//
//  Reset Alert.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-27.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class ResetAlert {
    
    let disableButtons       = DisableButtons()
    let buttonImagesForState = ButtonImagesForState()
    
    //App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let formatShotGoalPercentageAttributedString = FormatShotGoalPercentageAttributedString()
    
    //Passed Data
    var periodSelected: storeScoreClockDelegate?
    
    func showAlert(mainView: MainView) {
        
        let alertController = UIAlertController(title: "Start a new game?", message: "Starting a new game will empty both nets, reset the period, goalies and game.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel) {
            (action:UIAlertAction!) in
        }
        
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Yes", style: .default) {
            (action:UIAlertAction!) in
            
            self.yesAlert(mainView: mainView)
            
        }
        
        alertController.addAction(OKAction)
        
        
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        
        rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    func yesAlert(mainView: MainView) {
        
        //Empty the delegate
        appDelegate.leftGoalie  = nil
        appDelegate.rightGoalie = nil
        appDelegate.currentGame = nil
        
        //Empty Array
        GlobalVariables.myShotArray.removeAll()
        GlobalVariables.theirShotArray.removeAll()
        
        //Reset global variables
        GlobalVariables.myShotsOnNet    = 0
        GlobalVariables.myGoals         = 0
        GlobalVariables.theirShotsOnNet = 0
        GlobalVariables.theirGoals      = 0
        
        mainView.leftHockeyNetImageView.layer.sublayers?.removeAll()
        mainView.rightHockeyNetImageView.layer.sublayers?.removeAll()
        
        mainView.leftGoalieNameInformationLabel.attributedText = nil
        mainView.rightGoalieNameInformationLabel.attributedText = nil
        
        mainView.leftGoalieHeadshotImageView.image = UIImage(named: "account filled 50x50")
        mainView.rightGoalieHeadShotImageView.image = UIImage(named: "account filled 50x50")
        
        mainView.leftShotGoalPercentageLabel.attributedText = nil
        mainView.rightShotGoalPercentageLabel.attributedText = nil
        
        mainView.leftTeamNameLabel.text = "No Goalie"
        mainView.rightTeamNameLabel.text = "No Goalie"
        
        //switch back to 1st period
        buttonImagesForState.setButtonImages(period: .first, mainView: mainView)
        periodSelected?.storeScoreClock(periodSelected: .first)
        
        //Clear Delegates
        appDelegate.leftGoalieIndex  = nil
        appDelegate.rightGoalieIndex = nil
        
        disableButtons.disableButtons(mainView: mainView)
        
    }  //yesAlert
    
} //ResetAlert

