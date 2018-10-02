//
//  AppDelegate.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-01-24.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, storeCurrentGameDelegate, getMainImageSizeDelegate, storeLeftGoalieDelegate, storeRightGoalieDelegate, storeLeftGoalieIndexPathDelegate, storeRightGoalieIndexPathDelegate, storeScoreClockDelegate, storeLastShotsDelegate {
    
    var window: UIWindow?
    
    //delegate
    var leftGoalie: GoalieInformation?
    var rightGoalie: GoalieInformation?
    var leftGoalieIndex: IndexPath?
    var rightGoalieIndex: IndexPath?
    var periodSelected: Period?
    var myLastShot: [ShotDetails]?
    var theirLastShot: [ShotDetails]?
    
    var currentGame: GameInformation?
    
    //getMainImageSizeDelegate Delegate
    var mainImageHeight:CGFloat = 0.0
    var mainImageWidth:CGFloat  = 0.0
    var mainFrame:CGRect?
    
    //CoreData
    lazy var coreDataStack = CoreDataStack(modelName: "myShotTracker")
    
    //Classes
    let colourPalette = ColourPalette()
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Pretty up the place
        colourPalette.changeAppearance()
        
        let rootViewController = window?.rootViewController as! UITabBarController
        
        //Main Tab
        let scrollNavigationController  = rootViewController.viewControllers?[0] as! UINavigationController
        scrollNavigationController.navigationBar.isTranslucent = false
        
        let scrollViewController = scrollNavigationController.viewControllers[0] as! MainViewController
        
        //Pass Data
        scrollViewController.managedContext = coreDataStack.managedContext
        scrollViewController.leftGoalieDelegate  = self
        scrollViewController.rightGoalieDelegate = self
        scrollViewController.leftGoalieIndex     = self
        scrollViewController.rightGoalieIndex    = self
        scrollViewController.periodSelected      = self
        scrollViewController.storeImageSize      = self
        scrollViewController.lastShot            = self
        
        //Game Tab
        let gameNavigationController                           = rootViewController.viewControllers?[1] as! UINavigationController
        let gameInformationTableViewController                 = gameNavigationController.viewControllers[0] as! GameInformationTableViewController
        
        //Pass Data
        gameInformationTableViewController.managedContext      = coreDataStack.managedContext
        gameInformationTableViewController.currentGameDelegate = self
        
        
        //Goalie Tab
        let goalieNavigationController                             = rootViewController.viewControllers?[2] as! UINavigationController
        let goalieInformationTableViewController                   = goalieNavigationController.viewControllers[0] as! GoalieInformationTableViewController
        
        //Pass Data
        goalieInformationTableViewController.managedContext      = coreDataStack.managedContext
        goalieInformationTableViewController.leftGoalieDelegate  = self
        goalieInformationTableViewController.rightGoalieDelegate = self
        goalieInformationTableViewController.leftGoalieIndex     = self
        goalieInformationTableViewController.rightGoalieIndex    = self
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        //CoreData
        coreDataStack.saveContext()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        //CoreData
        coreDataStack.saveContext()
    }
    
    //Delegates
    
    func storeScoreClock(periodSelected: Period) {
        self.periodSelected = periodSelected
    }
    
    func storeLeftGoalie(leftGoalie: GoalieInformation) {
        self.leftGoalie    = leftGoalie
    }
    
    func storeRightGoalie(rightGoalie: GoalieInformation) {
        self.rightGoalie   = rightGoalie
    }
    
    func storeCurrentGame(currentGame: GameInformation) {
        self.currentGame = currentGame
    }
    
    func storeLeftGoalieIndex(leftGoalieIndex: IndexPath) {
        self.leftGoalieIndex = leftGoalieIndex
    }
    
    func storeRightGoalieIndex(rightGoalieIndex: IndexPath) {
        self.rightGoalieIndex = rightGoalieIndex
    }
    
    func getMainImageSize(mainImageHeight: CGFloat, mainImageWidth: CGFloat, mainFrame:CGRect) {
        
        self.mainImageHeight = mainImageHeight
        self.mainImageWidth  = mainImageWidth
        self.mainFrame       = mainFrame
        
        //        print("mainImageHeight \(mainImageHeight) mainImageWidth \(mainImageWidth) mainFrame \(mainFrame)")
        
    }
    
//    func storeLastShot(lastShot:[ShotDetails]) {
//        self.lastShot = lastShot
//    }
    
    func storeMyLastShot(myLastShot:[ShotDetails]) {
        self.myLastShot = myLastShot
        
    }
    func storeTheirLastShot(theirLastShot:[ShotDetails]) {
        self.theirLastShot = theirLastShot
        
    }
}
