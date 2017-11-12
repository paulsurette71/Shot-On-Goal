//
//  DisableButtons.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-15.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class DisableButtons {
    
    func disableButtons(mainView:MainView) {
        
        GlobalVariables.didDisableButtons = true
        
        //Disable all left buttons on screen
        mainView.leftUndoButton.isEnabled = false
        mainView.leftResetButton.isEnabled = false
        
        mainView.leftPeriodButton.isEnabled = false
//        mainView.leftPeriodButton.setImage(UIImage(named: "options 1st period disabled cell"), for: .disabled)
        
        mainView.leftShotDetailsButton.isEnabled = false
        mainView.leftHockeyNetImageView.isUserInteractionEnabled = false
        
        //Disable all left buttons on screen
        mainView.rightUndoButton.isEnabled = false
        mainView.rightResetButton.isEnabled = false
        
        mainView.rightPeriodButton.isEnabled = false
//        mainView.rightPeriodButton.setImage(UIImage(named: "options footer 1st period disabled"), for: .disabled)
        
        mainView.rightShotDetailsButton.isEnabled = false
        mainView.rightHockeyNetImageView.isUserInteractionEnabled = false
        
        
    } //disableButtons
    
} //DisableButtons

