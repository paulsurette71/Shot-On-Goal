//
//  GoalieInformationPopover.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-27.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class GoalieInformationPopover: UIViewController  {
    
    var leftGoalieDelegate: storeLeftGoalieDelegate?
    var rightGoalieDelegate: storeRightGoalieDelegate?
    var leftGoalieIndex: storeLeftGoalieIndexPathDelegate?
    var rightGoalieIndex: storeRightGoalieIndexPathDelegate?
    
    func showGoalieInformation(view: MainView,  managedContext: NSManagedObjectContext, sender: UIButton!) {
        
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        
        let myGoalieTableViewController = rootViewController?.storyboard?.instantiateViewController(withIdentifier: "MyGoalieTableViewController") as! MyGoalieTableViewController
        
        myGoalieTableViewController.managedContext = managedContext
        myGoalieTableViewController.mainView = view
        myGoalieTableViewController.modalPresentationStyle = .popover
        
        //Pass Delegates
        myGoalieTableViewController.leftGoalieDelegate  = leftGoalieDelegate
        myGoalieTableViewController.rightGoalieDelegate = rightGoalieDelegate
        myGoalieTableViewController.leftGoalieIndex     = leftGoalieIndex
        myGoalieTableViewController.rightGoalieIndex    = rightGoalieIndex
        
        //Pass current tapped button (left or right)
        myGoalieTableViewController.sender = sender
        
        let popover = myGoalieTableViewController.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = .any
        popover.sourceView = sender
        popover.sourceRect = sender.bounds
        
        rootViewController?.present(myGoalieTableViewController, animated: true, completion: nil)
    }
}

extension GoalieInformationPopover: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        
        return .none
    }
} //extension

