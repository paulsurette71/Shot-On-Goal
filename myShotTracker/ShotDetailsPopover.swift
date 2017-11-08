//
//  ShotDetailsPopover.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-27.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class ShotDetailsPopover: UIViewController {
    

    func showShotDetails(view: MainView, sender: UIButton) {
        
        print("class->ShotDetailsPopover->showShotDetails")
        
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        
        let shotDetailsTableViewController = rootViewController?.storyboard?.instantiateViewController(withIdentifier: "ShotDetailsTableViewController") as! ShotDetailsTableViewController
        
        shotDetailsTableViewController.modalPresentationStyle = .popover
        shotDetailsTableViewController.sender = sender
        shotDetailsTableViewController.mainView = view

        let popover = shotDetailsTableViewController.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = .any
        popover.sourceView = sender
        popover.sourceRect = sender.bounds

        rootViewController?.present(shotDetailsTableViewController, animated: true, completion: nil)
        
    }  //showShotDetails
}  //ShotDetailsPopover

extension ShotDetailsPopover: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        
        return .none
    }
} //extension
