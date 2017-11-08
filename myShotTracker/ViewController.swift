////
////  ViewController.swift
////  myShotTracker
////
////  Created by Surette, Paul on 2017-01-24.
////  Copyright © 2017 Surette, Paul. All rights reserved.
////
//
//import UIKit
//import CoreData
//
//class ViewController: UIViewController {
//    
//    //UILabel
//    @IBOutlet weak var goalieInformationLabel: UILabel!
//    @IBOutlet weak var periodLabel: UILabel!
//    @IBOutlet weak var timerLabel: UILabel!
//    @IBOutlet weak var shotsLabel: UILabel!
//    @IBOutlet weak var goalsLabel: UILabel!
//    @IBOutlet weak var savePercentageLabel: UILabel!
//    @IBOutlet weak var gameInformationLabel: UILabel!
//    @IBOutlet weak var advancedModeLabel: UILabel!
//    
//    //UIImageView
//    @IBOutlet weak var hockeyNetImageView: UIImageView!
//    @IBOutlet weak var goalieHeadShotImageView: UIImageView!
//    
//    //GestureRecognizer
//    @IBOutlet      var shotTapGestureRecognizer: UITapGestureRecognizer!
//    @IBOutlet      var goalLongPressGestureRecognizer: UILongPressGestureRecognizer!
//    
//    //UIButton
//    @IBOutlet weak var startButton: UIButton!
//    @IBOutlet weak var clearButton: UIButton!
//    @IBOutlet weak var undoButton: UIButton!
//    @IBOutlet weak var scoreClockButton: UIButton!
//    
//    //UISwitch
//    @IBOutlet weak var advancedModeSwitch: UISwitch!
//    
//    var dataReceived = ""
//    var shotsOnNet   = 0
//    var goals        = 0
//    
//    //Last Shot
//    var lastShotForUndo: [ShotDetails] = []
//    
//    let puckSize:CGFloat = 10
//    
//    //Collections
//    var shotArray = [Any]()
//    var shotDictionary = [String: Any]()
//    
//    //Score Clock
//    var scoreClock = Timer()
//    var secondsLeft = 0
//    var minutes = 0
//    var seconds = 0
//    
//    //CoreData
//    var managedContext: NSManagedObjectContext!
//    
//    //App Delegate
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    
//    //Classes
//    let drawPuck                 = DrawPuck()
//    let calculateSavePercentage  = CalculateSavePercentage()
//    let roundedImageView         = RoundedImageView()
//    let backButtonNav            = BackButtonNav()
//    let importTestData           = ImportTestData()
//    let isAppAlreadyLaunchedOnce = IsAppAlreadyLaunchedOnce()
//    
//    //Protocol
//    var storeImageSize: getMainImageSizeDelegate?
//    
//    //Score Clock buttons
//    let playButton  = UIImage(named: "start")
//    let pauseButton = UIImage(named: "pause")
//    
//    var shotsOnGoal:[[String:AnyObject]]?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //Make sure this is commented out when submitting to App Store for live app.
//        
////                if !isAppAlreadyLaunchedOnce.isAppAlreadyLaunchedOnce() {
////        
////                    //Import Test data
////                    importTestData.importGoalies()
////        
////                }
//        
//        roundedImageView.setRounded(image: goalieHeadShotImageView)
//        
//        storeImageSize?.getMainImageSize(mainImageHeight: hockeyNetImageView.frame.height, mainImageWidth: hockeyNetImageView.frame.width, mainFrame: hockeyNetImageView.frame)
//        
//
//        let shotGesture = UITapGestureRecognizer(target: self, action: #selector(shotOnNet))
//        let goalGesture = UILongPressGestureRecognizer(target: self, action: #selector(goalOnNet))
//        
//        hockeyNetImageView.addGestureRecognizer(shotGesture)
//        hockeyNetImageView.addGestureRecognizer(goalGesture)
//        
//        //disable clear Button
//        clearButton.isEnabled = false
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        //Hide the Navigation Bar
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        
//        showGoalieInformation()
//        showGameInformation()
//        showHeadShotForGoalie()
//        
//        guard (appDelegate.leftGoalie != nil), (appDelegate.rightGoalie != nil), (appDelegate.currentGame != nil) else {
//            
//            //Disable buttons
//            disableButtons()
//            
//            return
//        }
//        
//        enableButtons()
//        
//    }
//    
//    @IBAction func start(_ sender: Any) {
//        
//        if (sender as! UIButton).isSelected {
//            
//            (sender as! UIButton).setImage(playButton, for: UIControlState.normal)
//            (sender as! UIButton).isSelected = false
//            
//            //stop the timer
//            scoreClock.invalidate()
//            
//        } else {
//            
//            (sender as! UIButton).setImage(pauseButton, for: UIControlState.normal)
//            (sender as! UIButton).isSelected = true
//            
//            //stop the timer
//            scoreClock.invalidate()
//            
//            scoreClock = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateScoreClockLabel), userInfo: nil, repeats: true)
//        }
//    }
//    
//    @objc func updateScoreClockLabel () {
//        
//        if (secondsLeft > 0 ) {
//            
//            secondsLeft -= 1
//            
//            minutes = secondsLeft / 60
//            seconds = secondsLeft % 60
//            
//            timerLabel.text = String(format: "%02d:%02d",minutes, seconds)
//            
//        } else {
//            
//            //Stop the clock, change the button to start and disable start button
//            
//            scoreClock.invalidate()
//            startButton.isEnabled = false
//            startButton.setImage(UIImage(named: "start_disabled"), for: UIControlState.normal)
//            
//        }
//    }
//    
//    
//    @IBAction func adjustScoreClock(_ sender: Any) {
//        
//        //stop the timer - April 10th bug fix.
//        scoreClock.invalidate()
//        startButton.setImage(playButton, for: UIControlState.normal)
//        
//        let scoreClockPopoverViewController = storyboard?.instantiateViewController(withIdentifier: "ScoreClockPopoverStoryboard") as! ScoreClockPopoverViewController
//        
//
//        scoreClockPopoverViewController.modalPresentationStyle = .popover
//        
//        let popover = scoreClockPopoverViewController.popoverPresentationController!
//        popover.delegate = self
//        popover.permittedArrowDirections = .any
//        popover.sourceView = scoreClockButton
//        popover.sourceRect = scoreClockButton.bounds
//        
//        present(scoreClockPopoverViewController, animated: true, completion:nil)
//        
//    }
//    
//    // MARK: - Navigation
//    
//    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    //
//    //        if segue.identifier == "scoreClockSegue" {
//    //
//    //            if let scoreClockViewController = segue.destination as? ScoreClockViewController {
//    //
//    //                //Set Nav back button
//    //                backButtonNav.setBackButtonToBack(navItem: navigationItem)
//    //
//    //                scoreClockViewController.scoreClockTime          = timerLabel.text!
//    //                scoreClockViewController.scoreClockPeriod        = periodLabel.text!
//    //                scoreClockViewController.storeScoreClockDelegate = self
//    //
//    //            }
//    //        }
//    //    }
//    
//    func convertMinutesSecondsToSeconds(scoreClockTime: String) -> Int {
//        
//        var timerArray = scoreClockTime.components(separatedBy: ":")
//        
//        let minutes = Int(timerArray[0])! * 60
//        let seconds = Int(timerArray[1])
//        
//        return minutes + seconds!
//        
//    }
//    
//    //UITapGestureRecognizer
//    @IBAction func shotOnNet(_ sender: Any) {
//        
//        if !undoButton.isEnabled {
//            undoButton.isEnabled = true
//        }
//        
//        let shot = (sender as! UITapGestureRecognizer).location(ofTouch: 0, in: hockeyNetImageView)
//        
//        // Instantiate a new generator.
//        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
//        
//        // Prepare the generator when the gesture begins.
//        impactFeedbackGenerator.prepare()
//        
//        shotsOnNet += 1
//        shotsLabel.text = String(shotsOnNet)
//        
//        //Draw the puck
//        drawPuck.drawPuck(shot: shot, puckColour: UIColor.black.cgColor, puckSize: puckSize, imageView: hockeyNetImageView, shotNumber: String(shotsOnNet))
//        
//        //send feedback
//        impactFeedbackGenerator.impactOccurred()
//        
//        let savePercentage = calculateSavePercentage.calculateSavePercentage(shots: Double(shotsOnNet), goals: Double(goals))
//        
//        savePercentageLabel.text = savePercentage
//        
//        shotDictionary = ["shotnumber": shotsOnNet, "location": shot as Any, "timeOfShot": secondsLeft, "period": periodLabel.text!, "result": "shot"]
//        
//        shotArray.append(shotDictionary as AnyObject)
//        
//        updateCurrentGameWithShots(shotType: "shot")
//        
//        
//        //        if advancedModeSwitch.isOn {
//        //
//        //            showAdvanceModePopover(location: shot, puckSize: puckSize)
//        //
//        //        }
//    }
//    
//    @IBAction func goalOnNet(_ sender: Any) {
//        
//        if !undoButton.isEnabled {
//            undoButton.isEnabled = true
//        }
//        
//        // Instantiate a new generator.
//        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
//        
//        // Prepare the generator when the gesture begins.
//        impactFeedbackGenerator.prepare()
//        
//        if (sender as! UILongPressGestureRecognizer).state == .ended {
//            
//            let goal = (sender as! UILongPressGestureRecognizer).location(ofTouch: 0, in: hockeyNetImageView)
//            
//            shotsOnNet += 1
//            shotsLabel.text = String(shotsOnNet)
//            
//            goals += 1
//            goalsLabel.text = String(goals)
//            
//            drawPuck.drawPuck(shot: goal, puckColour: UIColor.red.cgColor, puckSize: puckSize, imageView: hockeyNetImageView, shotNumber: String(shotsOnNet))
//            
//            //send feedback
//            impactFeedbackGenerator.impactOccurred()
//            
//            let savePercentage = calculateSavePercentage.calculateSavePercentage(shots: Double(shotsOnNet), goals: Double(goals))
//            
//            savePercentageLabel.text = savePercentage
//            
//            shotDictionary = ["shotnumber": shotsOnNet, "location": goal as Any, "timeOfShot": secondsLeft, "period": periodLabel.text!, "result": "goal"]
//            
//            shotArray.append(shotDictionary as AnyObject)
//            
//            updateCurrentGameWithShots(shotType: "goal")
//            
//            //stop the timer after a goal.
//            scoreClock.invalidate()
//            
//            //reset the button to Play.
//            startButton.setImage(playButton, for: UIControlState.normal)
//            startButton.isSelected = false
//            
//        }
//    }
//    
//    @IBAction func clearNet(_ sender: Any) {
//        
//        showAlert()
//        
//    }
//    
//    @IBAction func undo(_ sender: Any) {
//        
//        if shotArray.count > 0 {
//            
//            //Check to see if the last shot was a shot or goal.
//            let lastShot = (shotArray.last as AnyObject).value(forKey: ("result"))
//            
//            //Delete last object (shot) from ShotDetails
//            let lastShotArray = lastShotForUndo.last!
//            managedContext.delete(lastShotArray)
//            
//            do {
//                try managedContext.save()
//            } catch let error as NSError {
//                print("ViewController|updateCurrentGameWithShots: Fetch error: \(error) description: \(error.userInfo)")
//            }
//            
//            //Delete last entry in shotArray and lastShotForUndo
//            shotArray.removeLast()
//            lastShotForUndo.removeLast()
//            
//            //Delete last puck and text that was drawn
//            hockeyNetImageView.layer.sublayers?.removeLast()
//            
//            
//            shotsOnNet -= 1
//            shotsLabel.text = String(shotsOnNet)
//            
//            if shotsOnNet == 0 {
//                
//                undoButton.isEnabled = false
//                
//                //Bug fix April 13, 2017
//                savePercentageLabel.text = "-"
//                
//            }
//            
//            if String(describing: lastShot!) == "goal" {
//                
//                goals -= 1
//                goalsLabel.text = String(goals)
//                
//                let savePercentage = calculateSavePercentage.calculateSavePercentage(shots: Double(shotsOnNet), goals: Double(goals))
//                
//                savePercentageLabel.text = savePercentage
//                
//            }
//            
//            //            do {
//            //                try managedContext.save()
//            //            } catch let error as NSError {
//            //                print("ViewController|updateCurrentGameWithShots: Fetch error: \(error) description: \(error.userInfo)")
//            //            }
//        }
//    }
//    
//    //Delegate Protocol
//    func storeScoreClock( period: String) {
//        
////        dataReceived = scoreClock
////        
////        let trimmedString = dataReceived.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
////        timerLabel.text = trimmedString
////        
////        secondsLeft = convertMinutesSecondsToSeconds(scoreClockTime: dataReceived)
////        
////        if secondsLeft != 0 {
////            
////            startButton.isEnabled = true
////            startButton.setImage(playButton, for: UIControlState.normal)
////            startButton.isSelected = false
////            
////        }
//        
////        switch period {
////        case "1st", "2nd", "3rd":
////            periodLabel.text = period + " period"
////        default:
////            periodLabel.text = period
////        }
//    }
//    
//    func showHeadShotForGoalie() {
//        
//        guard ((appDelegate.currentGoalie?.goalieHeadShot) != nil) else {
//            //no headshot
//            return
//        }
//        
//        goalieHeadShotImageView.contentMode = .scaleAspectFill
//        
//        let headShotImage = appDelegate.currentGoalie?.goalieHeadShot
//        
//        goalieHeadShotImageView.image = UIImage(data:headShotImage! as Data,scale:1.0)
//        
//    }
//    
//    func showGoalieInformation() {
//        
//        guard let currentGoalie = appDelegate.currentGoalie else {
//            
//            goalieInformationLabel.text = "No Goalie"
//            goalieHeadShotImageView.image = UIImage(named: "headshot")
//            
//            return
//            
//        }
//        
//        goalieInformationLabel.text = String(describing: currentGoalie.number!) + "|" + currentGoalie.firstName! + " " + currentGoalie.lastName!
//    }
//    
//    func showGameInformation() {
//        
//        guard let currentGame = appDelegate.currentGame else {
//            
//            gameInformationLabel.text = "No Game"
//            
//            return
//            
//        }
//        
//        //fetchShotsforDrawing()
//        
//        gameInformationLabel.text = "vs. " + String(describing: currentGame.oppositionCity!) + " " + String(describing: currentGame.oppositionTeamName!)
//        
//    }
//    
//    //    func checkToSeeIfSelectedGameHasShots() -> Bool {
//    //
//    //        print("checkToSeeIfSelectedGameHasShots")
//    //
//    //        guard let currentGame = appDelegate.currentGame else {
//    //
//    //            return false
//    //
//    //        }
//    //
//    //        //select count(*) from ZSHOTDETAILS where ZGAMERELATIONSHIP = 1;
//    //        let fetchRequest       = NSFetchRequest<NSFetchRequestResult>(entityName: "ShotDetails")
//    //        let predicate          = NSPredicate(format: "gameRelationship = %@", currentGame)
//    //        fetchRequest.predicate = predicate
//    //        fetchRequest.fetchBatchSize = 8
//    //
//    //        //count(ZSHOTTYPE)
//    //        let countExpressionDesc                  = NSExpressionDescription()
//    //        countExpressionDesc.name                 = "countShots"
//    //        countExpressionDesc.expression           = NSExpression(forFunction: "count:", arguments: [NSExpression(forKeyPath: "shotType")])
//    //        countExpressionDesc.expressionResultType = .integer16AttributeType
//    //
//    //        fetchRequest.propertiesToFetch = [countExpressionDesc]
//    //        fetchRequest.resultType        = .countResultType
//    //
//    //        var shotCounter = [Any]()
//    //
//    //        do {
//    //
//    //            shotCounter = try managedContext.fetch(fetchRequest)
//    //
//    //            print("shotCounter \(shotCounter)")
//    //
//    //        } catch let error as NSError {
//    //
//    //            print("ViewController|checkToSeeIfSelectedGameHasShots: Could not fetch. \(error), \(error.userInfo)")
//    //        }
//    //
//    //        return true
//    //    }
//    
//    func fetchShotsforDrawing() {
//        
//        //select ZGOALIERELATIONSHIP, ZSHOTLOCATION from ZSHOTDETAILS where ZGAMERELATIONSHIP = 5;
//        
//        guard let currentGame = appDelegate.currentGame else {
//            
//            return
//            
//        }
//        
//        //Empty the shot array --> March 22 <---
//        shotArray.removeAll()
//        
//        hockeyNetImageView.layer.sublayers?.removeAll()
//        shotsOnNet = 0
//        goals      = 0
//        
//        
//        let fetchRequest       = NSFetchRequest<NSFetchRequestResult>(entityName: "ShotDetails")
//        let predicate          = NSPredicate(format: "gameRelationship = %@", currentGame)
//        fetchRequest.predicate = predicate
//        fetchRequest.fetchBatchSize = 8
//        
//        fetchRequest.propertiesToFetch   = [#keyPath(ShotDetails.shotLocation),#keyPath(ShotDetails.shotType),#keyPath(ShotDetails.shotNumber), #keyPath(ShotDetails.shotScoreClock), #keyPath(ShotDetails.shotPeriod)]
//        fetchRequest.resultType          = .dictionaryResultType
//        
//        do {
//            
//            shotsOnGoal = try managedContext.fetch(fetchRequest) as? [[String:AnyObject]]
//            
//        } catch let error as NSError {
//            
//            print("GameDetailsTableViewController|fetchShotsforDrawing: Could not fetch. \(error), \(error.userInfo)")
//        }
//        
//        for shots in shotsOnGoal! {
//            
//            if String(describing: shots["shotType"]!) == "shot" {
//                
//                drawPuck.drawPuck(shot: shots["shotLocation"] as! CGPoint, puckColour: UIColor.black.cgColor, puckSize: puckSize, imageView: hockeyNetImageView, shotNumber: String(describing: shots["shotNumber"]!))
//                
//                shotsOnNet += 1
//                shotsLabel.text = String(shotsOnNet)
//                
//                shotDictionary = ["shotnumber": shots["shotNumber"]!, "location": shots["shotLocation"] as! CGPoint as Any, "timeOfShot": shots["shotScoreClock"]!, "period": shots["shotPeriod"]!, "result": shots["shotType"]!]
//                
//                shotArray.append(shotDictionary as AnyObject)
//                
//                
//                
//            } else {
//                
//                drawPuck.drawPuck(shot: shots["shotLocation"] as! CGPoint, puckColour: UIColor.red.cgColor, puckSize: puckSize, imageView: hockeyNetImageView, shotNumber: String(describing: shots["shotNumber"]!))
//                
//                goals += 1
//                goalsLabel.text = String(goals)
//                
//                shotsOnNet += 1
//                shotsLabel.text = String(shotsOnNet)
//                
//                shotDictionary = ["shotnumber": shots["shotNumber"]!, "location": shots["shotLocation"] as! CGPoint as Any, "timeOfShot": shots["shotScoreClock"]!, "period": shots["shotPeriod"]!, "result": shots["shotType"]!]
//                
//                shotArray.append(shotDictionary as AnyObject)
//                
//                
//            }
//        }
//    }
//    
//    
//    func updateCurrentGameWithShots(shotType:String) {
//        
//        do {
//            
//            //Current Game
//            
//            let entity = NSEntityDescription.entity(forEntityName: "ShotDetails", in: managedContext!)
//            let newShot = ShotDetails(entity: entity!, insertInto: managedContext!)
//            
//            newShot.gameRelationship   = appDelegate.currentGame
//            newShot.goalieRelationship = appDelegate.currentGoalie
//            
//            let shot     = shotArray.last
//            let lastShot = (shot as AnyObject).value(forKey: ("location"))
//            
//            newShot.shotScoreClock  = timerLabel.text
//            newShot.shotLocation    = lastShot as! NSObject?
//            newShot.shotNumber      = Int16(shotsOnNet)
//            newShot.shotType        = shotType
//            newShot.shotPeriod      = periodLabel.text!
//            newShot.shotDate        = NSDate()
//            
//            lastShotForUndo.append(newShot) //For Undo
//            
//            try managedContext.save()
//            
//            if advancedModeSwitch.isOn {
//                
//                showAdvanceModePopover(location: lastShot as! CGPoint, puckSize: puckSize, newShot: newShot, shotType: shotType)
//                
//            }
//            
//        } catch let error as NSError {
//            print("ViewController|updateCurrentGameWithShots: Fetch error: \(error) description: \(error.userInfo)")
//        }
//    }
//    
//    func showAlert() {
//        
//        let alertController = UIAlertController(title: "Start a new game?", message: "Starting a new game will empty the net, reset the clock, goalie and game.", preferredStyle: .alert)
//        
//        let cancelAction = UIAlertAction(title: "No", style: .cancel) {
//            (action:UIAlertAction!) in
//            
//            
//        }
//        
//        alertController.addAction(cancelAction)
//        
//        let OKAction = UIAlertAction(title: "Yes", style: .default) {
//            (action:UIAlertAction!) in
//            
//            self.yesAlert()
//            
//        }
//        
//        alertController.addAction(OKAction)
//        
//        present(alertController, animated: true, completion: nil)
//        
//    }
//    
//    func yesAlert() {
//        
//        //Empty the delegate
//        appDelegate.currentGoalie = nil
//        appDelegate.currentGame   = nil
//        
//        //Update goalie and game information
//        showGoalieInformation()
//        showGameInformation()
//        
//        //Empty the shot array --> March 22 <---
//        shotArray.removeAll()
//        
//        hockeyNetImageView.layer.sublayers?.removeAll()
//        shotsOnNet = 0
//        goals      = 0
//        
//        //Stop the clock
//        scoreClock.invalidate()
//        
//        //label
//        periodLabel.text = "1st Period"
//        timerLabel.text  = "00:00"
//        shotsLabel.text = "0"
//        goalsLabel.text = "0"
//        savePercentageLabel.text = "-"
//        
//        startButton.setImage(playButton, for: UIControlState.normal)
//        
//        goalieHeadShotImageView.image = UIImage(named: "headshot")
//        
//        advancedModeSwitch.isOn = false
//        advancedModeLabel.text = "Advanced OFF"
//        
//        disableButtons()
//    }
//    
//    func disableButtons() {
//        
//        //Disable all buttons on screen
//        
//        undoButton.isEnabled         = false
//        startButton.isEnabled        = false
//        scoreClockButton.isEnabled   = false
//        advancedModeSwitch.isEnabled = false
//        
//        //Disable tapping on screen
//        hockeyNetImageView.isUserInteractionEnabled = false
//        
//    }
//    
//    func enableButtons() {
//        
//        //Enable all buttons on screen
//        
//        if shotsOnNet > 0 {
//            
//            undoButton.isEnabled = true
//        }
//        
//        if secondsLeft > 0 {
//            
//            startButton.isEnabled = true
//        }
//        
//        clearButton.isEnabled        = true
//        scoreClockButton.isEnabled   = true
//        advancedModeSwitch.isEnabled = true
//        
//        //Enable tapping on screen
//        hockeyNetImageView.isUserInteractionEnabled = true
//        
//    }
//    
//    func showAdvanceModePopover(location: CGPoint, puckSize: CGFloat, newShot: ShotDetails, shotType: String) {
//        
////        let vc = storyboard?.instantiateViewController(withIdentifier: "AdvancedModePopoverViewController") as! AdvancedModePopoverViewController
////
////        vc.modalPresentationStyle = .popover
////        vc.newShot  = newShot
////        vc.shotType = shotType
////
////        let popover = vc.popoverPresentationController!
////        popover.delegate = self
////        popover.permittedArrowDirections = .any
////        popover.sourceView = hockeyNetImageView
////
////        let size = CGSize(width: puckSize, height: puckSize)
////        let origin = CGPoint(x: location.x - ( puckSize / 2) , y: location.y - ( puckSize / 2 ) )
////        popover.sourceRect = CGRect(origin: origin, size: size)
////
////        present(vc, animated: true, completion:nil)
//    }
//    
////    @IBAction func advancedMode(_ sender: Any) {
////
////        switch (sender as! UISwitch).isOn {
////        case true:
////            advancedModeLabel.text = "Advanced ON"
////        default:
////            advancedModeLabel.text = "Advanced OFF"
////        }
////    }
//}
//
//extension ViewController: UIPopoverPresentationControllerDelegate {
//    
//    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
//        
//        return .none
//    }
//    
//    
//} //extension

