//
//  ShowGoalieInformation.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-30.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class ShowGoalieInformation {
    
    func showGoalie(mainView:MainView, sender: UIButton!) {
        
        //App Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let formatShotGoalPercentageAttributedString = FormatShotGoalPercentageAttributedString()
        let goalieDetailsAttributedString = GoalieDetailsAttributedString()
        
        if sender == mainView.leftGoalieButton {
            
            guard let currentGoalie = appDelegate.leftGoalie else {
                
                mainView.leftGoalieNameInformationLabel.attributedText = nil
                mainView.leftGoalieHeadshotImageView.image = UIImage(named: "account filled 50x50")
                mainView.leftTeamNameLabel.text = "No Goalie"
//                mainView.leftShotGoalPercentageLabel.attributedText = formatShotGoalPercentageAttributedString.defaultGoalPercentage()
                
                return
            }
            
            mainView.leftGoalieNameInformationLabel.attributedText = goalieDetailsAttributedString.goalieDetailInformation(number: currentGoalie.number!, firstName: currentGoalie.firstName!, lastName: currentGoalie.lastName!)
            mainView.leftTeamNameLabel.text                        = currentGoalie.city! + " " + currentGoalie.teamName!
            mainView.leftGoalieHeadshotImageView.image = UIImage(data:currentGoalie.goalieHeadShot! as Data,scale:1.0)
            
        } else if sender == mainView.rightGoalieButton {
            
            guard let currentGoalie = appDelegate.rightGoalie else {
                
                mainView.rightGoalieNameInformationLabel.attributedText = nil
                mainView.rightGoalieHeadShotImageView.image = UIImage(named: "account filled 50x50")
                mainView.rightTeamNameLabel.text = "No Goalie"
//                mainView.rightShotGoalPercentageLabel.attributedText = formatShotGoalPercentageAttributedString.defaultGoalPercentage()
                
                return
            }
            
            mainView.rightGoalieNameInformationLabel.attributedText = goalieDetailsAttributedString.goalieDetailInformation(number: currentGoalie.number!, firstName: currentGoalie.firstName!, lastName: currentGoalie.lastName!)
            mainView.rightTeamNameLabel.text                        = currentGoalie.city! + " " + currentGoalie.teamName!
            mainView.rightGoalieHeadShotImageView.image = UIImage(data:currentGoalie.goalieHeadShot! as Data,scale:1.0)

        }
        
    }  //showGoalie
    
} //ShowGoalieInformation
