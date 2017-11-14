//
//  TapHintPopover.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-11-14.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class TapHintPopover {
    
    func showTapHintPopoverOnFirstShot(shot:CGPoint, image: UIImageView, delegate: MainView){

        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        
        let tapHintViewController = rootViewController?.storyboard?.instantiateViewController(withIdentifier: "TapHint")
        
        tapHintViewController?.modalPresentationStyle = .popover
        tapHintViewController?.preferredContentSize = CGSize(width: 200, height: 130)
        
        
        let popover = tapHintViewController?.popoverPresentationController!
        popover?.delegate = delegate
        popover?.permittedArrowDirections = .any
        popover?.sourceView = image
        popover?.sourceRect = CGRect(x: shot.x, y: shot.y, width: 0, height: 0)

        
        rootViewController?.present(tapHintViewController!, animated: true, completion: nil)
    
    }  //showTapHintPopoverOnFirstShot
    
}  //TapHintPopover
