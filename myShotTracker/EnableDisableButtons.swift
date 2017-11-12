//
//  EnableDisableButtons.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-31.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class EnableDisableButtons {
    
    //App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func checkForGoalieAndGame(mainView: MainView) {
        
        print("class->EnableDisableButtons->checkForGoalieAndGame")
        
        let disableButtons = DisableButtons()
        let enableButtons = EnableButtons()
        
        guard (appDelegate.leftGoalie != nil || appDelegate.rightGoalie != nil), (appDelegate.currentGame != nil) else {
            
            //Disable buttons
            disableButtons.disableButtons(mainView: mainView)
            
            return
        }
        
        //Enable buttons
        enableButtons.enableButtons(mainView: mainView)

    }
}
