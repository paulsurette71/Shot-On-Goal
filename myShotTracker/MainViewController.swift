//
//  MainViewController.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-27.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit
import CoreData

enum Period: String {
    case first    = "1st Period"
    case second   = "2nd Period"
    case third    = "3rd Period"
    case overtime = "Over Time"
    case shootout = "Shoot Out"
}

enum shotType: String {
    case shot = "shot"
    case goal = "goal"
}

struct ShotInfo {
    let shotNumber: Int
    let location: CGPoint
    let timeOfShot: Date
    let timeDifference: TimeInterval
    let period: Period
    let result: shotType
}

struct GlobalVariables {
    
    //Collections
    static var myShotArray: [ShotInfo] = []
    static var theirShotArray: [ShotInfo] = []
    
    static var myShotsOnNet      = 0
    static var myGoals           = 0
    static var theirShotsOnNet   = 0
    static var theirGoals        = 0
    static var didDisableButtons = false
    static var visibleIndexPaths = [IndexPath]()
    static var didReset          = false
}

class MainViewController: UIViewController {
    
    var mainView: MainView?
    var selectedPeriod:Period = .first
    
    //CoreData
    var managedContext: NSManagedObjectContext!
    
    //Protocol
    var leftGoalieDelegate:  storeLeftGoalieDelegate?
    var rightGoalieDelegate: storeRightGoalieDelegate?
    var leftGoalieIndex:     storeLeftGoalieIndexPathDelegate?
    var rightGoalieIndex:    storeRightGoalieIndexPathDelegate?
    var periodSelected:      storeScoreClockDelegate?
    var storeImageSize:      getMainImageSizeDelegate?
//    var leftGoalieLastShot:  storeLastShotsDelegate?
//    var rightGoalieLastShot: storeLastShotsDelegate?
    var lastShot:            storeLastShotsDelegate?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("viewDidLoad->MainViewController")
        
        mainView = UINib(nibName: "MainView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? MainView
        
//        let isAppAlreadyLaunchedOnce = IsAppAlreadyLaunchedOnce()
//        let importTestData           = ImportTestData()
//        
//        if !isAppAlreadyLaunchedOnce.isAppAlreadyLaunchedOnce() {
//            
//            //Import Test data
//            importTestData.importGoalies()
//            
//        }
        

        
        
        setupScrollView()
        setupGestures()
        setupUI()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let enableDisableButtons = EnableDisableButtons()
        enableDisableButtons.checkForGoalieAndGame(mainView: mainView!)
        
        //        let disableButtons = DisableButtons()
        //        let enableButtons = EnableButtons()
        //
        //        guard (appDelegate.leftGoalie != nil || appDelegate.rightGoalie != nil), (appDelegate.currentGame != nil) else {
        //
        //            //Disable buttons
        //            disableButtons.disableButtons(mainView: mainView!)
        //
        //            return
        //        }
        //
        //        //Enable buttons
        //        enableButtons.enableButtons(mainView: mainView!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupGestures() {
        
        //UITapGestureRecognizer
        let leftShotGesture = UITapGestureRecognizer(target: mainView, action: #selector(mainView?.leftShotOnNet(_:)))
        let rightShotGesture = UITapGestureRecognizer(target: mainView, action: #selector(mainView?.rightShotOnNet(_:)))
        
        let leftLongPressGestureRecognizer = UILongPressGestureRecognizer(target: mainView, action: #selector(mainView?.leftGoalOnNet(_:)))
        let rightLongPressGestureRecognizer = UILongPressGestureRecognizer(target: mainView, action: #selector(mainView?.rightGoalOnNet(_:)))
        
        mainView?.leftHockeyNetImageView.addGestureRecognizer(leftLongPressGestureRecognizer)
        mainView?.leftHockeyNetImageView.addGestureRecognizer(leftShotGesture)
        mainView?.leftHockeyNetImageView.isUserInteractionEnabled = true
        
        mainView?.rightHockeyNetImageView.addGestureRecognizer(rightLongPressGestureRecognizer)
        mainView?.rightHockeyNetImageView.addGestureRecognizer(rightShotGesture)
        mainView?.rightHockeyNetImageView.isUserInteractionEnabled = true
        
    }
    
    func setupUI() {
        
        //Classes
        let roundedImageView = RoundedImageView()
        
        roundedImageView.setRounded(image: (mainView?.leftGoalieHeadshotImageView)!)
        roundedImageView.setRounded(image: (mainView?.rightGoalieHeadShotImageView)!)
        
        //disable clear Button
        mainView?.leftResetButton.isEnabled = false
        mainView?.rightResetButton.isEnabled = false
        
        storeImageSize?.getMainImageSize(mainImageHeight: (mainView?.leftHockeyNetImageView.frame.height)!, mainImageWidth: (mainView?.leftHockeyNetImageView.frame.width)!, mainFrame: (mainView?.leftHockeyNetImageView.frame)!)
        
    }
    
    func goalOnNet()  {
        
    }
    
    func setupScrollView() {
        
        //Determine how big the tabBar is
        let tabBarHeight = self.tabBarController?.tabBar.frame.height
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: (mainView?.bounds.width)!, height: (mainView?.bounds.height)! - tabBarHeight!)
        scrollView.addSubview(mainView!)
        view.addSubview(scrollView)
        
        //Pass data
        mainView?.managedContext      = managedContext
        mainView?.selectedPeriod      = selectedPeriod
        mainView?.leftGoalieDelegate  = leftGoalieDelegate
        mainView?.rightGoalieDelegate = rightGoalieDelegate
        mainView?.leftGoalieIndex     = leftGoalieIndex
        mainView?.rightGoalieIndex    = rightGoalieIndex
        mainView?.periodSelected      = periodSelected
//        mainView?.leftGoalieLastShot  = leftGoalieLastShot
//        mainView?.rightGoalieLastShot = rightGoalieLastShot
        mainView?.lastShot            = lastShot
        
    } //setupScrollView
    
} //MainViewController

extension MainViewController: UIScrollViewDelegate {
    
} //extension

