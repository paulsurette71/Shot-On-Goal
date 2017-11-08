//
//  BackButtonNav.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-03-11.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class BackButtonNav {
    
    func setBackButtonToBack(navItem: UINavigationItem ) {
        
        //Set Nav back button
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        backItem.setTitleTextAttributes([ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .thin)], for: .normal)
        navItem.backBarButtonItem = backItem

    }    
}
