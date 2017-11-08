//
//  GameInformationTableViewController.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-02-10.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit
import CoreData

class GameInformationTableViewController: UITableViewController {
    
    //CoreData
    var managedContext: NSManagedObjectContext!
    var selectedGame: GameInformation?
    var fetchedResultsController: NSFetchedResultsController<GameInformation>!
    
    //Protocol
    var currentGameDelegate: storeCurrentGameDelegate?
    
    
    //Fetched Data
    @objc var shotsOnGoalie: [NSManagedObject] = []
    
    var numberOfGames:Int = 0
    
    //Classes
    let convertDate             = ConvertDate()
    let backButtonNav           = BackButtonNav()
    let calculateSavePercentage = CalculateSavePercentage()
    let gameDateAttribString    = GameDateAttribString()
    let formatShotGoalPercentageAttributedString = FormatShotGoalPercentageAttributedString()
    
    //App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Save selected Row between views
    var selectedRow: IndexPath! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("1. viewDidLoad->GameInformationTableViewController")
        
        //Setup Custom NIB
        let cellNib = UINib(nibName: "GameInformationTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "gameCell")
        tableView.rowHeight = 82
        
        let fetchRequest: NSFetchRequest<GameInformation> = GameInformation.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(GameInformation.gameDateTime), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.fetchBatchSize = 8
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("GameInformationTableViewController|viewDidLoad: Fetching error: \(error), \(error.userInfo)")
        }
        
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if appDelegate.currentGame == nil {
            if selectedRow != nil {
                
                let cell = tableView?.cellForRow(at: selectedRow) as! GameInformationTableViewCell
                cell.checkMarkImageView.isHidden = true
                selectedRow = nil
                
            }
        }
        
        tableView.reloadData()
    }
        
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        guard let sections = fetchedResultsController.sections else {
            
            return 0
        }
        
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sectionInfo = fetchedResultsController.sections?[section] else {
            
            return 0
        }
        
        numberOfGames = sectionInfo.numberOfObjects
        
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Games " + String(describing: numberOfGames)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameInformationTableViewCell
        
        cell.selectionStyle = .none
        cell.chevronButton.tag = indexPath.row
        cell.chevronButton.addTarget(self, action: #selector(gameDetails), for: .touchUpInside)
        
        
        let game = fetchedResultsController.object(at: indexPath)
        
        let currentDate = convertDate.convertDate(date: (game.gameDateTime)!)
        
        cell.gameInformationLabel.attributedText = gameDateAttribString.gameDateAtrib(curentDate: currentDate, oppositionCity:  game.oppositionCity!, oppositionTeamName: game.oppositionTeamName!)
        
        let numberOfShots = fetchShots(indexPath: indexPath)
//        fetchTestShots(indexPath: indexPath)
        
        
        cell.shotInformationLabel.attributedText = formatShotGoalPercentageAttributedString.formattedString(shots: Int(numberOfShots.shots)!, goals: Int(numberOfShots.goals)!, fontSize: 17)
        
        //This is to check to see if the checkmark needs to be removed or stick to the same cell.
        if selectedRow != nil {
            
            if selectedRow == indexPath {
                
                cell.checkMarkImageView.isHidden = false
                
            } else {
                
                cell.checkMarkImageView.isHidden = true
                
            }
        }
        
        return cell
    }
    
    @objc func gameDetails(sender: UIButton)  {
        
        //This replaces accessoryButtonTappedForRowWith
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        
        selectedGame = self.fetchedResultsController.object(at: indexPath as IndexPath)
        
        let gameDetailsTableViewController = storyboard?.instantiateViewController(withIdentifier: "GameDetailsTableViewController") as! GameDetailsTableViewController
        
        gameDetailsTableViewController.detailItem = selectedGame
        gameDetailsTableViewController.managedContext = managedContext
        
        //Set Nav back button
        backButtonNav.setBackButtonToBack(navItem: navigationItem)
        
        self.navigationController?.pushViewController(gameDetailsTableViewController, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        guard (selectedRow != nil) else {
            return true
        }
        
        if indexPath == selectedRow {
            
            return false
            
        } else {
            
            return true
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if(editingStyle == .delete ) {
            
            let gameToDelete = fetchedResultsController.object(at:indexPath)
            managedContext.delete(gameToDelete)
            
            do {
                try managedContext.save()
                tableView.reloadData()
                
            } catch let error as NSError {
                print("GameInformationTableViewController|editingStyle: Saving error: \(error), description: \(error.userInfo)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! GameInformationTableViewCell
        
        if cell.checkMarkImageView.isHidden {
            
            cell.checkMarkImageView.isHidden = false
            
            selectedRow = indexPath
            
            selectedGame = self.fetchedResultsController.object(at: indexPath)
            
            currentGameDelegate?.storeCurrentGame(currentGame: selectedGame!)
            
        } else {
            
            cell.checkMarkImageView.isHidden = true
            
            selectedRow = nil
            
            appDelegate.currentGame = nil
        }
        
        //reloading the table will get rid of the checkmark if already selected.
        tableView.reloadData()
        
        
        /*
         
         if selectedRow == nil {
         
         let cell = tableView.cellForRow(at: indexPath) as! GameInformationTableViewCell
         
         selectedRow = indexPath
         
         cell.checkmarkButton.isHidden = false
         
         selectedGame = self.fetchedResultsController.object(at: indexPath)
         
         currentGameDelegate?.storeCurrentGame(currentGame: selectedGame!)
         
         
         } else {
         
         let cellWithCheckMark = tableView.cellForRow(at: selectedRow) as! GameInformationTableViewCell
         let cellWithNoCheckMark = tableView.cellForRow(at: indexPath) as! GameInformationTableViewCell
         
         if selectedRow == indexPath {
         
         cellWithCheckMark.checkmarkButton.isHidden = true
         selectedRow = nil
         appDelegate.currentGame = nil
         
         } else {
         
         cellWithCheckMark.checkmarkButton.isHidden = true
         cellWithNoCheckMark.checkmarkButton.isHidden = false
         
         selectedRow = indexPath
         
         }
         }
         
         */
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        //http://stackoverflow.com/questions/19802336/changing-font-size-for-uitableview-section-headers
        
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .natural
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let gameDetailsTableViewController = segue.destination as! GameDetailsTableViewController
        
        if segue.identifier == "newGameSegue" {
            
            //Set Nav back button
            backButtonNav.setBackButtonToBack(navItem: navigationItem)
            
            gameDetailsTableViewController.managedContext = managedContext
            gameDetailsTableViewController.newGame = true
        }
    }
    
    func fetchShots(indexPath: IndexPath) -> (shots: String, goals: String, savePercentage:String) {
        
        let fetchRequest: NSFetchRequest<ShotDetails> = ShotDetails.fetchRequest()
        
        let selectedGameIndexPath = self.fetchedResultsController.object(at: indexPath)
        
        let predicate = NSPredicate(format: "gameRelationship = %@", selectedGameIndexPath)
        
        let sort = NSSortDescriptor(key: #keyPath(ShotDetails.goalieRelationship), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.predicate = predicate
        fetchRequest.fetchBatchSize = 8
        
        do {
            shotsOnGoalie = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            print("GameInformationTableViewController|fetchShots: Could not fetch. \(error), \(error.userInfo)")
        }
        
        //filter array for TableViewCell subtitle.
        
        let goalPredicate = NSPredicate(format: "shotType = 'goal'")
        let goalsOnGoalieFilteredArray = (shotsOnGoalie as NSArray).filtered(using: goalPredicate)
        
        //Go get the save %
        let savePercentage = calculateSavePercentage.calculateSavePercentage(shots: Double(shotsOnGoalie.count), goals: Double(goalsOnGoalieFilteredArray.count))
        let shots = String(shotsOnGoalie.count)
        let goals = String(goalsOnGoalieFilteredArray.count)
        
        return (shots, goals, savePercentage)
        
    }
    
//    ////
//
//    func fetchTestShots(indexPath: IndexPath) {
//
//        //http://stackoverflow.com/questions/37306769/how-to-aggregate-in-swift
//
//        //select ZGOALIERELATIONSHIP, count(ZSHOTTYPE) from ZSHOTDETAILS where ZGAMERELATIONSHIP = 6 group by ZGOALIERELATIONSHIP;
//
//        let selectedGameIndexPath = self.fetchedResultsController.object(at: indexPath)
//
//        let fetchRequest       = NSFetchRequest<NSFetchRequestResult>(entityName: "ShotDetails")
//        let predicate          = NSPredicate(format: "gameRelationship = %@", selectedGameIndexPath)
//        fetchRequest.predicate = predicate
//        fetchRequest.fetchBatchSize = 8
//
//        //count(ZSHOTTYPE)
//        let countExpressionDesc                  = NSExpressionDescription()
//        countExpressionDesc.name                 = "countShots"
//        countExpressionDesc.expression           = NSExpression(forFunction: "count:", arguments: [NSExpression(forKeyPath: "shotType")])
//        countExpressionDesc.expressionResultType = .integer16AttributeType
//
//        fetchRequest.propertiesToGroupBy = [#keyPath(ShotDetails.goalieRelationship.lastName), #keyPath(ShotDetails.goalieRelationship.firstName), #keyPath(ShotDetails.shotType)]
//        //        fetchRequest.propertiesToGroupBy = [#keyPath(ShotDetails.goalieRelationship.firstName)]
//        fetchRequest.propertiesToFetch   = [#keyPath(ShotDetails.goalieRelationship.firstName), #keyPath(ShotDetails.goalieRelationship.lastName), #keyPath(ShotDetails.shotType), countExpressionDesc]
//        fetchRequest.resultType          = .dictionaryResultType
//
//        do {
//
//            let fetchShotsResults = try managedContext.fetch(fetchRequest) as? [[String:AnyObject]]
//
//        } catch let error as NSError {
//
//            print("GameDetailsTableViewController|fetchShots: Could not fetch. \(error), \(error.userInfo)")
//        }
//    }
//
//
//    ////
}

// MARK: - NSFetchedResultsControllerDelegate
extension GameInformationTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            
            tableView?.insertRows(at: [newIndexPath!], with: .automatic)
            tableView?.reloadData()  //Update Game Header count
            
        case .delete:
            
             /*
             
             CoreData: error: Serious application error.  Exception was caught during Core Data change processing.  This is usually a bug within an observer of NSManagedObjectContextObjectsDidChangeNotification.  UITableView internal inconsistency: the _swipedIndexPath cannot be nil if the swipe to delete row is being deleted in _updateRowsAtIndexPaths:withUpdateAction:rowAnimation:usingPresentationValues: with userInfo (null)
             libc++abi.dylib: terminating with uncaught exception of type NSException
             
             */
            
            tableView?.deleteRows(at: [indexPath!], with: .automatic)
            
            //reset the current game as it's been deleted.
            appDelegate.currentGame = nil
            
        case .update:
            
            tableView?.reloadData()
            
        case .move:
            
            tableView?.deleteRows(at: [indexPath!], with: .automatic)
            tableView?.insertRows(at: [newIndexPath!], with: .automatic)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView?.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let indexSet = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            tableView?.insertSections(indexSet, with: .fade)
            
        case .delete:
            
            tableView?.deleteSections(indexSet, with: .fade)
            
        default: break
        }
    }
    
}
