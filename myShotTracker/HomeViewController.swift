////
////  HomeViewController.swift
////  Shot On Goal
////
////  Created by Surette, Paul on 2017-10-10.
////  Copyright © 2017 Surette, Paul. All rights reserved.
////
//
//
//import UIKit
//import CoreData
//
//enum Period: String {
//    case first    = "1st Period"
//    case second   = "2nd Period"
//    case third    = "3rd Period"
//    case overtime = "Over Time"
//    case shootout = "Shoot Out"
//}
//
//enum shotType {
//    case shot
//    case goal
//}
//
//struct ShotInfo {
//    let shotNumber: Int
//    let location: CGPoint
//    let timeOfShot: Date
//    let timeDifference: TimeInterval
//    let period: Period
//    let result: shotType
//}
//
//struct GlobalVariables {
//    
//    //Collections
//    static var myShotArray: [ShotInfo] = []
//    static var theirShotArray: [ShotInfo] = []
//    
//    static var myShotsOnNet      = 0
//    static var myGoals           = 0
//    static var theirShotsOnNet   = 0
//    static var theirGoals        = 0
//    static var didDisableButtons = false
//    static var visibleIndexPaths = [IndexPath]()
//    static var didReset          = false
//}
//
////CollectionView Indexs
//let myGoalieInformationIndexPath    = IndexPath(row: 0, section: 0)
//let myGoalieHockeyNetIndexPath      = IndexPath(row: 1, section: 0)
//let theirGoalieHockeyNetIndexPath   = IndexPath(row: 2, section: 0)
//let theirGoalieInformationIndexPath = IndexPath(row: 3, section: 0)
//
//
//class HomeViewController: UIViewController, storeScoreClockDelegate {
//    
//    //CoreData
//    var managedContext: NSManagedObjectContext!
//    
//    //App Delegate
//    let appDelegate             = UIApplication.shared.delegate as! AppDelegate
//    let showMyGoalieInformation = ShowMyGoalieInformation()
//    let showMyGameInformation   = ShowMyGameInformation()
//    let shotHeadShot            = ShowHeadShot()
//    let enableButtons           = EnableButtons()
//    let disableButtons          = DisableButtons()
//    let formatShotGoalPercentageAttributedString = FormatShotGoalPercentageAttributedString()
//    
//    //Protocol
//    var storeImageSize:      getMainImageSizeDelegate?
//    var storeCollectionView: storeCollectionViewDelegate?
//    
//    //CollectionView
//    @IBOutlet weak var collectionView: UICollectionView!
//    
//    //Classes
//    let drawPuck                 = DrawPuck()
//    let calculateSavePercentage  = CalculateSavePercentage()
//    let reset                    = ResetAlert()
//    let importTestData           = ImportTestData()
//    let isAppAlreadyLaunchedOnce = IsAppAlreadyLaunchedOnce()
//    
//    let puckSize:CGFloat = 10
//    
//    var selectedPeriod:Period = .first
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view.
//        
//        //Make sure this is commented out when submitting to App Store for live app.
//        
////        if !isAppAlreadyLaunchedOnce.isAppAlreadyLaunchedOnce() {
////
////            //Import Test data
////            importTestData.importGoalies()
////
////        }
//        
//        
//        // Register cell classes
//        collectionView!.register(UINib(nibName: "HeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCell")
//        collectionView!.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCell")
//        collectionView!.register(UINib(nibName: "TheirHockeyNetCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TheirHockeyNet")
//        collectionView!.register(UINib(nibName: "FooterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FooterCell")
//        
//        //Move collection to centre
//        collectionView.scrollToItem(at: theirGoalieInformationIndexPath, at: .centeredHorizontally, animated: true)
//        
//        //Store CollectionView
//        storeCollectionView?.storeCollectionViewReference(collectionView: collectionView)
//        
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        //Hide the Navigation Bar
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        GlobalVariables.visibleIndexPaths = fullyVisibleCells(self.collectionView)
//        
//        if GlobalVariables.visibleIndexPaths.contains(myGoalieHockeyNetIndexPath) {
//            
//            showMyGoalieInformation.showMyGoalieInformation(collectionView: collectionView)
//            showMyGameInformation.showMyGameInformation(collectionView: collectionView)
//            shotHeadShot.showHeadShotForGoalie(collectionView: collectionView)
//            
//            let myGoalieInformationCell = collectionView!.cellForItem(at: myGoalieInformationIndexPath) as! HeaderCollectionViewCell
//            myGoalieInformationCell.delegate = self
//            
//            guard (appDelegate.currentGoalie != nil), (appDelegate.currentGame != nil) else {
//                
//                //Disable buttons
//                disableButtons.disableButtons(collectionView: collectionView)
//                
//                return
//            }
//            
//            //Enable buttons
//            enableButtons.enableButtons(collectionView: collectionView)
//            
//        } else if GlobalVariables.visibleIndexPaths.contains(theirGoalieHockeyNetIndexPath) {
//            
//            showMyGoalieInformation.showMyGoalieInformation(collectionView: collectionView)
//            showMyGameInformation.showMyGameInformation(collectionView: collectionView)
//            shotHeadShot.showHeadShotForGoalie(collectionView: collectionView)
//            
//            let theirGoalieInformationCell = collectionView!.cellForItem(at: theirGoalieInformationIndexPath) as! FooterCollectionViewCell
//            theirGoalieInformationCell.delegate = self
//            
//            guard (appDelegate.currentGoalie != nil), (appDelegate.currentGame != nil) else {
//                
//                //Disable buttons
//                disableButtons.disableButtons(collectionView: collectionView)
//                
//                return
//            }
//            
//            //Enable buttons
//            enableButtons.enableButtons(collectionView: collectionView)
//            
//        }
//    }
//    
//    @IBAction func shotOnNet(_ sender: Any) {
//        
//        if GlobalVariables.visibleIndexPaths.contains(myGoalieHockeyNetIndexPath) {
//            
//            let myGoalieInformationCell = collectionView!.cellForItem(at: myGoalieInformationIndexPath) as! HeaderCollectionViewCell
//            let myGoalieHockeyNetCell   = collectionView.cellForItem(at: myGoalieHockeyNetIndexPath) as! MainCollectionViewCell
//            let shotOnHockeyNet         = myGoalieHockeyNetCell.hockeyNetImageView
//            
//            if !myGoalieInformationCell.undoButton.isEnabled {
//                myGoalieInformationCell.undoButton.isEnabled = true
//            }
//            
//            let shot = (sender as! UITapGestureRecognizer).location(ofTouch: 0, in: shotOnHockeyNet)
//            
//            GlobalVariables.myShotsOnNet += 1
//            
//            //Draw the puck
//            drawPuck.drawPuck(shot: shot, puckColour: UIColor.black.cgColor, puckSize: puckSize, imageView: shotOnHockeyNet!, shotNumber: String(GlobalVariables.myShotsOnNet))
//            
//            let timeDifference = calculateDifferenceInTime(array: GlobalVariables.myShotArray)
//            
//            let shotString = formatShotGoalPercentageAttributedString.formattedString(shots: GlobalVariables.myShotsOnNet, goals: GlobalVariables.myGoals)
//            myGoalieInformationCell.myShotGoalPercentageLabel.attributedText = shotString
//            
//            let shotInfo = ShotInfo(shotNumber: GlobalVariables.myShotsOnNet, location: shot, timeOfShot: Date(), timeDifference: timeDifference, period: selectedPeriod , result: .shot)
//            
//            GlobalVariables.myShotArray.append(shotInfo)
//            
//        } else if GlobalVariables.visibleIndexPaths.contains(theirGoalieHockeyNetIndexPath) {
//            
//            //Theirs
//            let theirGoalieHockeyNetCell   = collectionView.cellForItem(at: theirGoalieHockeyNetIndexPath) as! TheirHockeyNetCollectionViewCell
//            let theirShotOnHockeyNet       = theirGoalieHockeyNetCell.theirHockeyNetImageView
//            var theirGoalieInformationCell = FooterCollectionViewCell()
//            
//            if GlobalVariables.visibleIndexPaths.contains(theirGoalieInformationIndexPath) {
//                theirGoalieInformationCell = collectionView!.cellForItem(at: theirGoalieInformationIndexPath) as! FooterCollectionViewCell
//                
//                if !theirGoalieInformationCell.theirUndoButton.isEnabled {
//                    theirGoalieInformationCell.theirUndoButton.isEnabled = true
//                }
//            }
//            
//            let shot = (sender as! UITapGestureRecognizer).location(ofTouch: 0, in: theirShotOnHockeyNet)
//            
//            GlobalVariables.theirShotsOnNet += 1
//            
//            //Draw the puck
//            drawPuck.drawPuck(shot: shot, puckColour: UIColor.black.cgColor, puckSize: puckSize, imageView: theirShotOnHockeyNet!, shotNumber: String(GlobalVariables.theirShotsOnNet))
//            
//            let timeDifference = calculateDifferenceInTime(array: GlobalVariables.theirShotArray)
//            
//            if GlobalVariables.visibleIndexPaths.contains(theirGoalieInformationIndexPath) {
//                let shotString = formatShotGoalPercentageAttributedString.formattedString(shots: GlobalVariables.theirShotsOnNet, goals: GlobalVariables.theirGoals)
//                theirGoalieInformationCell.theirShotGoalPercentageLabel.attributedText = shotString
//            }
//            let shotInfo = ShotInfo(shotNumber: GlobalVariables.theirShotsOnNet, location: shot, timeOfShot: Date(), timeDifference: timeDifference, period: selectedPeriod , result: .shot)
//            
//            GlobalVariables.theirShotArray.append(shotInfo)
//            
//            //            if visibleIndexPaths.contains(theirGoalieInformationIndexPath) {
//            //                theirGoalieInformationCell.fillTheirTableView()
//            //            }
//        }
//    }
//    
//    @IBAction func goalOnNet(_ sender: Any) {
//        
//        if GlobalVariables.visibleIndexPaths.contains(theirGoalieHockeyNetIndexPath) {
//            
//            let theirGoalieInformationCell = collectionView!.cellForItem(at: theirGoalieInformationIndexPath ) as! FooterCollectionViewCell
//            let theirGoalieHockeyNetCell   = collectionView.cellForItem(at: theirGoalieHockeyNetIndexPath ) as! TheirHockeyNetCollectionViewCell
//            let theirshotOnHockeyNet         = theirGoalieHockeyNetCell.theirHockeyNetImageView
//            
//            if (sender as! UILongPressGestureRecognizer).state == .ended {
//                
//                let goal = (sender as! UILongPressGestureRecognizer).location(ofTouch: 0, in: theirshotOnHockeyNet)
//                
//                GlobalVariables.theirShotsOnNet += 1
//                
//                GlobalVariables.theirGoals += 1
//                
//                //Draw the puck
//                drawPuck.drawPuck(shot: goal, puckColour: UIColor.red.cgColor, puckSize: puckSize, imageView: theirshotOnHockeyNet!, shotNumber: String(GlobalVariables.theirShotsOnNet))
//                
//                let shotString = formatShotGoalPercentageAttributedString.formattedString(shots: GlobalVariables.theirShotsOnNet, goals: GlobalVariables.theirGoals)
//                theirGoalieInformationCell.theirShotGoalPercentageLabel.attributedText = shotString
//                
//                let timeDifference = calculateDifferenceInTime(array: GlobalVariables.theirShotArray)
//                
//                let shotInfo = ShotInfo(shotNumber: GlobalVariables.theirShotsOnNet, location: goal, timeOfShot: Date(), timeDifference: timeDifference, period: selectedPeriod , result: .goal)
//                
//                GlobalVariables.theirShotArray.append(shotInfo)
//                //                theirGoalieInformationCell.fillTheirTableView()
//                
//            }
//        } else if GlobalVariables.visibleIndexPaths.contains(myGoalieHockeyNetIndexPath) {
//            
//            let myGoalieInformationCell = collectionView!.cellForItem(at: myGoalieInformationIndexPath) as! HeaderCollectionViewCell
//            let myGoalieHockeyNetCell   = collectionView.cellForItem(at: myGoalieHockeyNetIndexPath) as! MainCollectionViewCell
//            let shotOnHockeyNet         = myGoalieHockeyNetCell.hockeyNetImageView
//            
//            if (sender as! UILongPressGestureRecognizer).state == .ended {
//                
//                let goal = (sender as! UILongPressGestureRecognizer).location(ofTouch: 0, in: shotOnHockeyNet)
//                
//                GlobalVariables.myShotsOnNet += 1
//                
//                GlobalVariables.myGoals += 1
//                
//                //Draw the puck
//                drawPuck.drawPuck(shot: goal, puckColour: UIColor.red.cgColor, puckSize: puckSize, imageView: shotOnHockeyNet!, shotNumber: String(GlobalVariables.myShotsOnNet))
//                
//                let shotString = formatShotGoalPercentageAttributedString.formattedString(shots: GlobalVariables.myShotsOnNet, goals: GlobalVariables.myGoals)
//                myGoalieInformationCell.myShotGoalPercentageLabel.attributedText = shotString
//                
//                let timeDifference = calculateDifferenceInTime(array: GlobalVariables.myShotArray)
//                
//                let shotInfo = ShotInfo(shotNumber: GlobalVariables.myShotsOnNet, location: goal, timeOfShot: Date(), timeDifference: timeDifference, period: selectedPeriod , result: .goal)
//                
//                GlobalVariables.myShotArray.append(shotInfo)
//                
//            }
//            
//        }
//    }
//    
//    func calculateDifferenceInTime(array: [ShotInfo]) -> TimeInterval {
//        
//        //Make sure there is at least 1 object in the array before continuing.
//        guard array.count > 0 else {
//            
//            return 0
//        }
//        
//        let previousShotDate = array.last?.timeOfShot
//        let lastShotDate     = Date()
//        let timeDifference   = lastShotDate.timeIntervalSince(previousShotDate!)
//        
//        return timeDifference
//    }
//    
//    //Delegate Protocol
//    func storeScoreClock(periodSelected: Period) {
//        
//        switch periodSelected {
//        case .first:
//            selectedPeriod = Period.first
//        case .second:
//            selectedPeriod = Period.second
//        case .third:
//            selectedPeriod = Period.third
//        case .overtime:
//            selectedPeriod = Period.overtime
//        case .shootout:
//            selectedPeriod = Period.shootout
//        }
//    }
//}
//
//extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    
//    // MARK: UICollectionViewDataSource
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        
//        return 1
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//        return 4
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        switch indexPath.row {
//        case 0:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCollectionViewCell
//            
//            // Configure the cell
//            
//            return cell
//            
//        case 1:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainCollectionViewCell
//            
//            //Configure the cell
//            let shotGesture = UITapGestureRecognizer(target: self, action: #selector(shotOnNet))
//            let goalGesture = UILongPressGestureRecognizer(target: self, action: #selector(goalOnNet))
//            
//            cell.hockeyNetImageView.addGestureRecognizer(shotGesture)
//            cell.hockeyNetImageView.addGestureRecognizer(goalGesture)
//            
//            return cell
//            
//        case 2:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TheirHockeyNet", for: indexPath) as! TheirHockeyNetCollectionViewCell
//            
//            //Configure the cell
//            let shotGesture = UITapGestureRecognizer(target: self, action: #selector(shotOnNet))
//            let goalGesture = UILongPressGestureRecognizer(target: self, action: #selector(goalOnNet))
//            
//            cell.theirHockeyNetImageView.addGestureRecognizer(shotGesture)
//            cell.theirHockeyNetImageView.addGestureRecognizer(goalGesture)
//            
//            return cell
//        case 3:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FooterCell", for: indexPath) as! FooterCollectionViewCell
//            
//            // Configure the cell
//            
//            return cell
//        default:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FooterCell", for: indexPath) as! FooterCollectionViewCell
//            
//            // Configure the cell
//            
//            return cell
//        }
//        
//    }
//    
//    // MARK: UICollectionViewDelegate
//    
//    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    //
//    //        //Move collection to centre
//    ////        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//    //
//    //    }
//    
//    //UICollectionViewDelegateFlowLayout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        //Determine how big the tabBar is
//        let tabBarHeight = self.tabBarController?.tabBar.frame.height
//        
//        //Determine how big the screen height is.
//        let screenHeight = UIScreen.main.bounds.size.height
//        
//        //Determine the difference in screenHeight - tabBarHeight!
//        let collectionViewHeight = screenHeight - tabBarHeight!
//        
//        if indexPath.row == 0 || indexPath.row == 3 {
//            
//            return CGSize(width: 170.0, height: collectionViewHeight)
//            
//        } else {
//            
//            //- 15 is for some padding on the edges.
//            return CGSize(width: 454.0, height: collectionViewHeight - 15)
//            
//        }
//    }
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        
//        GlobalVariables.visibleIndexPaths = fullyVisibleCells(self.collectionView)
////        print("Visible IndexPath -> \(GlobalVariables.visibleIndexPaths)")
//        
//        guard !GlobalVariables.visibleIndexPaths.isEmpty else {
//            return
//        }
//        
//        if GlobalVariables.visibleIndexPaths.contains(myGoalieHockeyNetIndexPath) {
//            
//            if GlobalVariables.didDisableButtons {
//                
//                disableButtons.disableButtons(collectionView: collectionView)
//                reset.yesAlert(collectionView: collectionView, indexPath: myGoalieInformationIndexPath)
//                
//            } else {
//                
//                //Enable tapping on screen
//                let myGoalieHockeyNetCell   = collectionView!.cellForItem(at: myGoalieHockeyNetIndexPath) as! MainCollectionViewCell
//                myGoalieHockeyNetCell.hockeyNetImageView.isUserInteractionEnabled = true
//                
//                let theirGoalieHockeyNetCell   = collectionView!.cellForItem(at: theirGoalieHockeyNetIndexPath ) as! TheirHockeyNetCollectionViewCell
//                theirGoalieHockeyNetCell.theirHockeyNetImageView.isUserInteractionEnabled = false
//            }
//        }
//        
//        if GlobalVariables.visibleIndexPaths.contains(theirGoalieHockeyNetIndexPath) {
//            
//            if GlobalVariables.didDisableButtons {
//                
//                disableButtons.disableButtons(collectionView: collectionView)
//                reset.yesAlert(collectionView: collectionView, indexPath: theirGoalieInformationIndexPath)
//                
//            } else {
//                
//                //Enable tapping on screen
//                let theirGoalieHockeyNetCell   = collectionView!.cellForItem(at: theirGoalieHockeyNetIndexPath ) as! TheirHockeyNetCollectionViewCell
//                theirGoalieHockeyNetCell.theirHockeyNetImageView.isUserInteractionEnabled = true
//                
//                let myGoalieHockeyNetCell   = collectionView!.cellForItem(at: myGoalieHockeyNetIndexPath) as! MainCollectionViewCell
//                myGoalieHockeyNetCell.hockeyNetImageView.isUserInteractionEnabled = false
//            }
//        }
//        
//        if GlobalVariables.visibleIndexPaths.contains(theirGoalieInformationIndexPath) {
//            
//            //pass delegate for Goalies.
//            let theirGoalieInformationCell = collectionView!.cellForItem(at: theirGoalieInformationIndexPath) as! FooterCollectionViewCell
//            theirGoalieInformationCell.delegate = self
//            
//        }
//    }
//    
//    func fullyVisibleCells(_ inCollectionView: UICollectionView) -> [IndexPath] {
//        
//        // https://stackoverflow.com/questions/46829901/how-to-determine-when-a-custom-uicollectionviewcell-is-100-on-the-screen/46833430#46833430
//        
//        var returnCells = [IndexPath]()
//        
//        var visibleCollectionViewCells = inCollectionView.visibleCells
//        
//        visibleCollectionViewCells = visibleCollectionViewCells.filter({ cell -> Bool in
//            
//            let cellRect = inCollectionView.convert(cell.frame, to: inCollectionView.superview)
//            
//            return inCollectionView.frame.contains(cellRect)
//        })
//        
//        visibleCollectionViewCells.forEach({
//            
//            if let pth = inCollectionView.indexPath(for: $0) {
//                
//                returnCells.append(pth)
//            }
//        })
//        
//        return returnCells
//    }
//}
//
//extension HomeViewController: UIPopoverPresentationControllerDelegate {
//    
//    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
//        
//        return .none
//    }
//} //extension
//
//extension HomeViewController: HeaderCollectionViewCellDelegate {
//    
//    func didClickPeriod() {
//        
//        let scoreClockPopoverViewController = storyboard?.instantiateViewController(withIdentifier: "ScoreClockPopoverStoryboard") as! ScoreClockPopoverViewController
//        
//        scoreClockPopoverViewController.currentPeriod           = selectedPeriod
//        scoreClockPopoverViewController.storeScoreClockDelegate = self
//        scoreClockPopoverViewController.modalPresentationStyle = .popover
//        
//        let popover = scoreClockPopoverViewController.popoverPresentationController!
//        popover.delegate = self
//        popover.permittedArrowDirections = .any
//        
//        let headerCollectionViewCell   = collectionView.cellForItem(at: myGoalieInformationIndexPath) as! HeaderCollectionViewCell
//        popover.sourceView = headerCollectionViewCell.periodButton
//        popover.sourceRect = headerCollectionViewCell.periodButton.bounds
//        
//        present(scoreClockPopoverViewController, animated: true, completion:nil)
//        
//    }
//    
//    func selectGoalie() {
//        
//        let myGoalieTableViewController = storyboard?.instantiateViewController(withIdentifier: "MyGoalieTableViewController") as! MyGoalieTableViewController
//        
//        myGoalieTableViewController.managedContext = managedContext
//        myGoalieTableViewController.modalPresentationStyle = .popover
//        
//        if GlobalVariables.visibleIndexPaths.contains(myGoalieInformationIndexPath) {
//            let myGoalieTableViewController = storyboard?.instantiateViewController(withIdentifier: "MyGoalieTableViewController") as! MyGoalieTableViewController
//            
//            myGoalieTableViewController.managedContext = managedContext
//            myGoalieTableViewController.modalPresentationStyle = .popover
//            
//            
//            let popover = myGoalieTableViewController.popoverPresentationController!
//            popover.delegate = self
//            popover.permittedArrowDirections = .any
//            
//            let headerCollectionViewCell   = collectionView.cellForItem(at: myGoalieInformationIndexPath) as! HeaderCollectionViewCell
//            popover.sourceView = headerCollectionViewCell.goalieButton
//            popover.sourceRect = headerCollectionViewCell.goalieButton.bounds
//            
//            present(myGoalieTableViewController, animated: true, completion:nil)
//            
//        } else  if GlobalVariables.visibleIndexPaths.contains(theirGoalieInformationIndexPath) {
//            
//            let popover = myGoalieTableViewController.popoverPresentationController!
//            popover.delegate = self
//            popover.permittedArrowDirections = .any
//            
//            let footerCollectionViewCell   = collectionView.cellForItem(at: theirGoalieInformationIndexPath) as! FooterCollectionViewCell
//            popover.sourceView = footerCollectionViewCell.theirGoalieButton
//            popover.sourceRect = footerCollectionViewCell.theirGoalieButton.bounds
//            
//            present(myGoalieTableViewController, animated: true, completion:nil)
//            
//        }
//        
//    } //selectGoalie
//    
//    func selectShotDetails() {
//        
//        let shotDetailsTableViewController = storyboard?.instantiateViewController(withIdentifier: "ShotDetailsTableViewController") as! ShotDetailsTableViewController
//        
//        shotDetailsTableViewController.modalPresentationStyle = .popover
//        
//        let popover = shotDetailsTableViewController.popoverPresentationController!
//        popover.delegate = self
//        popover.permittedArrowDirections = .any
//        
//        let headerCollectionViewCell   = collectionView.cellForItem(at: myGoalieInformationIndexPath) as! HeaderCollectionViewCell
//        popover.sourceView = headerCollectionViewCell.shotDetailsButton
//        popover.sourceRect = headerCollectionViewCell.shotDetailsButton.bounds
//        
//        present(shotDetailsTableViewController, animated: true, completion:nil)
//        
//    } //selectShotDetails
//    
//    
//    
//}
//
