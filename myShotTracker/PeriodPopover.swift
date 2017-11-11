//
//  PeriodPopover.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-27.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class PeriodPopover: UIViewController {
    
    //Passed Data
    var periodSelected: storeScoreClockDelegate?
    var mainView: MainView?
    
    func showPeriodPopover(view: MainView, selectedPeriod: Period, sender: UIButton) {
        
        print("class->PeriodPopover->showPeriodPopover")
        
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        
        let scoreClockPopoverViewController = rootViewController?.storyboard?.instantiateViewController(withIdentifier: "ScoreClockPopoverStoryboard") as! ScoreClockPopoverViewController
        
        scoreClockPopoverViewController.periodSelected         = periodSelected
        scoreClockPopoverViewController.mainView               = mainView
        scoreClockPopoverViewController.sender                 = sender
        scoreClockPopoverViewController.modalPresentationStyle = .popover
                
        let popover = scoreClockPopoverViewController.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = .any
        
        popover.sourceView = sender
        popover.sourceRect = sender.bounds
        
        rootViewController?.present(scoreClockPopoverViewController, animated: true, completion: nil)
        
    }  //showPeriodPopover
    
}  //PeriodPopover

extension PeriodPopover: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        
        return .none
    }
} //extension
