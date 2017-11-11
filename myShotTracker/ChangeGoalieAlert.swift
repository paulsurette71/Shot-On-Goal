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
    
    func showAlert(viewController: UIViewController, mainView: MainView, tableView: UITableView, currentGoalieIndex:IndexPath) {
        
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
            
            self.yesAlert(mainView: mainView)
            
        }
        
        alertController.addAction(OKAction)
        
        
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
    func yesAlert(mainView: MainView) {
        
        //Empty the delegate
        //            appDelegate.leftGoalie  = nil
        //            appDelegate.rightGoalie = nil
        //            appDelegate.currentGame = nil
        
        //Empty Array
        GlobalVariables.myShotArray.removeAll()
        //            GlobalVariables.theirShotArray.removeAll()
        
        //Reset global variables
        GlobalVariables.myShotsOnNet    = 0
        GlobalVariables.myGoals         = 0
        //            GlobalVariables.theirShotsOnNet = 0
        //            GlobalVariables.theirGoals      = 0
        
        mainView.leftHockeyNetImageView.layer.sublayers?.removeAll()
        //            mainView.rightHockeyNetImageView.layer.sublayers?.removeAll()
        
        mainView.leftGoalieNameInformationLabel.attributedText = nil
        //            mainView.rightGoalieNameInformationLabel.attributedText = nil
        
        mainView.leftGoalieHeadshotImageView.image = UIImage(named: "account filled 50x50")
        //            mainView.rightGoalieHeadShotImageView.image = UIImage(named: "account filled 50x50")
        
                mainView.leftShotGoalPercentageLabel.attributedText = nil // attributedText = formatShotGoalPercentageAttributedString.defaultGoalPercentage()
        //        mainView.rightShotGoalPercentageLabel.attributedText = formatShotGoalPercentageAttributedString.defaultGoalPercentage()
        
        mainView.leftTeamNameLabel.text = "No Goalie"
        //            mainView.rightTeamNameLabel.text = "No Goalie"
        
        appDelegate.leftGoalieIndex  = nil
        //            appDelegate.rightGoalieIndex = nil
        
        disableButtons.disableButtons(mainView: mainView)
        
    }  //yesAlert
    
}  //ChangeGoalieAlert
