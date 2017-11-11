//
//  ChangeGoalieAlert.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-11-10.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class ChangeGoalieAlert {
    
    let disableButtons = DisableButtons()
    
    //App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let formatShotGoalPercentageAttributedString = FormatShotGoalPercentageAttributedString()
    
    func showAlert(viewController: UIViewController, mainView: MainView, tableView: UITableView, currentGoalieIndex:IndexPath, sender: UIButton) {
        
        print("class->ChangeGoalieAlert->showAlert")
        
        let alertController = UIAlertController(title: "Pull the goalie?", message: "Are you sure you want to pull the goalie?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel) {
            (action:UIAlertAction!) in
        }
        
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Yes", style: .default) {
            (action:UIAlertAction!) in
            
            //remove old checkmark
            let oldCell = tableView.cellForRow(at: currentGoalieIndex) as! MyGoalieTableViewCell
            oldCell.checkmarkImageView.isHidden = true
            
            self.yesAlert(mainView: mainView, sender: sender)
            
        }
        
        alertController.addAction(OKAction)
        
        
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
    func yesAlert(mainView: MainView, sender: UIButton) {
        
        if sender == mainView.leftGoalieButton {
            
            print("left button")
            
            //Empty the delegate
            appDelegate.leftGoalie  = nil
            appDelegate.leftGoalieIndex  = nil
            
            //Empty Array
            GlobalVariables.myShotArray.removeAll()
            
            //Reset global variables
            GlobalVariables.myShotsOnNet    = 0
            GlobalVariables.myGoals         = 0
            
            mainView.leftHockeyNetImageView.layer.sublayers?.removeAll()
            mainView.leftGoalieNameInformationLabel.attributedText = nil
            mainView.leftGoalieHeadshotImageView.image = UIImage(named: "account filled 50x50")
            mainView.leftShotGoalPercentageLabel.attributedText = nil
            mainView.leftTeamNameLabel.text = "No Goalie"
            
            //Disable all left buttons on screen
            mainView.leftUndoButton.isEnabled = false
            mainView.leftResetButton.isEnabled = false
            
            mainView.leftPeriodButton.isEnabled = false
            mainView.leftPeriodButton.setImage(UIImage(named: "options 1st period disabled cell"), for: .disabled)
            
            mainView.leftShotDetailsButton.isEnabled = false
            mainView.leftHockeyNetImageView.isUserInteractionEnabled = false

            
        } else {
            
            print("right button")
            
            //Empty the delegate
            appDelegate.rightGoalie = nil
            appDelegate.rightGoalieIndex = nil
            
            //Empty Array
            GlobalVariables.theirShotArray.removeAll()
            
            //Reset global variables
            GlobalVariables.theirShotsOnNet = 0
            GlobalVariables.theirGoals      = 0
            
            mainView.rightHockeyNetImageView.layer.sublayers?.removeAll()
            mainView.rightGoalieNameInformationLabel.attributedText = nil
            mainView.rightGoalieHeadShotImageView.image = UIImage(named: "account filled 50x50")
            mainView.rightShotGoalPercentageLabel.attributedText = nil
            mainView.rightTeamNameLabel.text = "No Goalie"
            
            //Disable all left buttons on screen
            mainView.rightUndoButton.isEnabled = false
            mainView.rightResetButton.isEnabled = false
            
            mainView.rightPeriodButton.isEnabled = false
            mainView.rightPeriodButton.setImage(UIImage(named: "options footer 1st period disabled"), for: .disabled)
            
            mainView.rightShotDetailsButton.isEnabled = false
            mainView.rightHockeyNetImageView.isUserInteractionEnabled = false

        }
        
    }  //yesAlert
    
}  //ChangeGoalieAlert
