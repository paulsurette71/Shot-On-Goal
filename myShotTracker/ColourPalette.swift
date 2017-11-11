//
//  ColourPalette.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-03-06.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit


class ColourPalette {
    
    //http://www.htmlportal.net/colors/shades-of-gray.php
    
    func changeAppearance() {
        
        //UINavigationBar
        UINavigationBar.appearance().tintColor           = UIColor(named: "hockeyNetRed")
        UINavigationBar.appearance().barTintColor        = UIColor(named: "linkWater")
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        UINavigationBar.appearance().titleTextAttributes = [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28, weight: .heavy)]
        
        //UITabBar
        UITabBar.appearance().tintColor               = UIColor(named: "hockeyNetRed")
        UITabBar.appearance().barTintColor            = UIColor(named: "linkWater")
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        
        //UITableView
        UITableView.appearance().backgroundColor = UIColor(named: "primaryLight")
        UITableView.appearance().separatorColor  = UIColor(named: "divider")
        
        //UIButton
        UIButton.appearance().tintColor = UIColor(named: "hockeyNetRed")
        
        //UIPicker
        UIPickerView.appearance().tintColor = UIColor(named: "primaryLight")
        
        //UIDatePicker
        UIDatePicker.appearance().tintColor = UIColor(named: "primaryLight")
        
    }
}
