//
//  ThereAppearsToBe.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-11-11.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class ThereAppearsToBe {
    
    func aGameInProgress(viewController: UIViewController ) {
                
        let alertController = UIAlertController(title: "Game already in Progress?", message: "To change the game, you have to reset from the Home tab.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) {
            (action:UIAlertAction!) in
            
        }
        
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
        
    }  //aGameInProgress
}  //ThereAppearsToBe
