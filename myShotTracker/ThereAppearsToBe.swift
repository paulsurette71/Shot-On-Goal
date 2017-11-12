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
    
    func aGameInProgress(viewController: UIViewController, tableView: UITableView, indexPath: IndexPath) {
        
        print("class->ThereAppearsToBe->aGameInProgress")
        
        let alertController = UIAlertController(title: "A Game in Progress?", message: "Are you sure you want to change the game?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel) {
            (action:UIAlertAction!) in
        }
        
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Yes", style: .default) {
            (action:UIAlertAction!) in
            
            //remove old checkmark
            let cell = tableView.cellForRow(at: indexPath) as! GameInformationTableViewCell
            cell.checkMarkImageView.isHidden = true
            
//            self.yesAlert(mainView: mainView, sender: sender)
            
        }
        
        alertController.addAction(OKAction)
        
        
        viewController.present(alertController, animated: true, completion: nil)
        
        
        
    }  //aGameInProgress
}  //ThereAppearsToBe
