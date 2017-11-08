//
//  EnableButtons.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-15.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class EnableButtons {
    
    //App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func enableButtons(mainView:MainView) {
        
        GlobalVariables.didDisableButtons = false
        
        if (appDelegate.leftGoalie != nil) {
            
            if GlobalVariables.myShotsOnNet > 0 {
                
                mainView.leftUndoButton.isEnabled = true
            }
            
            //Enable all left buttons on screen
            mainView.leftResetButton.isEnabled = true
            
            mainView.leftPeriodButton.isEnabled = true
            mainView.leftPeriodButton.setImage(UIImage(named: "options 1st period enabled cell"), for: .normal)
            
            mainView.leftHockeyNetImageView.isUserInteractionEnabled = true
            
        }
        
        if (appDelegate.rightGoalie != nil) {
            
            if GlobalVariables.theirShotsOnNet > 0 {
                
                mainView.rightUndoButton.isEnabled = true
            }
            
            //Enable all right buttons on screen
            mainView.rightResetButton.isEnabled = true
            
            mainView.rightPeriodButton.isEnabled = true
            mainView.rightPeriodButton.setImage(UIImage(named: "options footer 1st period enabled"), for: .normal)
            
            mainView.rightHockeyNetImageView.isUserInteractionEnabled = true
            
        }
        
    }  //enableButtons
} //EnableButtons

