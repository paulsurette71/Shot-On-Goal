//
//  GoalieInformationTableViewController.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-02-09.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit 
import CoreData

class GoalieInformationTableViewController: UITableViewController {
    
    //CoreData
    var managedContext: NSManagedObjectContext!
    var selectedGoalie: GoalieInformation?
    var fetchedResultsController: NSFetchedResultsController<GoalieInformation>!
    
    //Fetched Data
    var goalsOnGoalie = [ShotDetails]()
    var shotsOnGoalie = [ShotDetails]()
    
    //Protocol
    var leftGoalieDelegate: storeLeftGoalieDelegate?
    var rightGoalieDelegate: storeRightGoalieDelegate?
    var leftGoalieIndex: storeLeftGoalieIndexPathDelegate?
    var rightGoalieIndex: storeRightGoalieIndexPathDelegate?
    
    
    //App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let formatShotGoalPercentageAttributedString = FormatShotGoalPercentageAttributedString()
    
    var numberOfGoalies:Int = 0
    
    //Classes
    let calculateSavePercentage = CalculateSavePercentage()
    let roundedImageView        = RoundedImageView()
    let backButtonNav           = BackButtonNav()
    let goalieDetailsAttributedString = GoalieDetailsAttributedString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("1. viewDidLoad->GoalieInformationTableViewController")
        
        //Setup Custom NIB
        let cellNib = UINib(nibName: "GoalieInformationTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "goalieCell")
        tableView.rowHeight = 82
        
        let fetchRequest: NSFetchRequest<GoalieInformation> = GoalieInformation.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(GoalieInformation.lastName), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.fetchBatchSize = 8
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("GoalieInformationTableViewController|viewDidLoad: Fetching error: \(error), \(error.userInfo)")
        }
        
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //    //        if appDelegate.currentGoalie == nil {
        //                  if appDelegate.leftGoalie == nil {
        //                if selectedRow != nil {
        //
        //                    let cell = tableView.cellForRow(at: selectedRow) as! GoalieInformationTableViewCell
        //                    cell.checkMarkImageView.isHidden = true
        //                    selectedRow = nil
        //
        //                }
        //            }
        
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
        
        numberOfGoalies = sectionInfo.numberOfObjects
        
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        //http://stackoverflow.com/questions/19802336/changing-font-size-for-uitableview-section-headers
        
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Goalies " + String(describing: numberOfGoalies)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalieCell", for: indexPath) as! GoalieInformationTableViewCell
        
        //turn on/off checkmark
        if appDelegate.leftGoalieIndex == indexPath || appDelegate.rightGoalieIndex == indexPath {
            
            cell.checkMarkImageView.isHidden = false
            
        } else {
            
            cell.checkMarkImageView.isHidden = true
        }
        
        
        cell.selectionStyle = .none
        
        roundedImageView.setRounded(image: cell.goalieHeadShotImageView, colour: "hockeyNetRed")
        
        let goalie        = fetchedResultsController.object(at: indexPath)
        let numberOfShots = fetchShots(indexPath: indexPath)
        
        cell.chevronButton.tag = indexPath.row
        cell.detailsButton.tag = indexPath.row
        
        if numberOfShots.shots == "0" {
            //goalie has no shots
            cell.detailsButton.isHidden = true
        } else {
            cell.detailsButton.isHidden = false
            
        }
        
        cell.chevronButton.addTarget(self, action: #selector(goalieDetails), for: .touchUpInside)
        cell.detailsButton.addTarget(self, action: #selector(goalieShotDetails), for: .touchUpInside)
        
        
        //        cell.goalieInformationLabel.text = goalie.number! + "|" + goalie.firstName! + " " + goalie.lastName!
        
        cell.goalieInformationLabel.attributedText = goalieDetailsAttributedString.goalieDetailInformation(number: goalie.number!, firstName: goalie.firstName!, lastName: goalie.lastName!)
        
        cell.goalieHeadShotImageView.image = UIImage(data:goalie.goalieHeadShot! as Data,scale:1.0)
        
//        //Change goals in string to red.
//        let numberOfGoalsAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: numberOfShots.goals)
//        numberOfGoalsAttributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSMakeRange(0, numberOfGoalsAttributedString.length))
//        
//        let numberOfShotsAttributedString = NSMutableAttributedString(string: numberOfShots.shots)
//        let savePercentageAttributedString = NSMutableAttributedString(string: numberOfShots.savePercentage)
//        
//        let combination = NSMutableAttributedString()
//        let pipeString = NSMutableAttributedString(string: "|")
//        //        let percentString = NSMutableAttributedString(string: " %")
//        
//        
//        combination.append(numberOfShotsAttributedString)
//        combination.append(pipeString)
//        combination.append(numberOfGoalsAttributedString)
//        combination.append(pipeString)
//        combination.append(savePercentageAttributedString)
//        //        combination.append(percentString)
//        
//        cell.shotInformationLabel.attributedText = combination
        cell.shotInformationLabel.attributedText = formatShotGoalPercentageAttributedString.formattedString(shots: Int(numberOfShots.shots)!, goals: Int(numberOfShots.goals)!, fontSize: 17)
        
        //        //This is to check to see if the checkmark needs to be removed or stick to the same cell.
        //        if selectedRow != nil {
        //
        //            if selectedRow == indexPath {
        //
        //                cell.checkMarkImageView.isHidden = false
        //
        //            } else {
        //
        //                cell.checkMarkImageView.isHidden = true
        //
        //            }
        //        }
        
        
        return cell
    }
    
    
    //    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //
    //        guard (selectedRow != nil) else {
    //            return true
    //        }
    //
    //        if indexPath == selectedRow {
    //
    //            return false
    //
    //        } else {
    //
    //            return true
    //        }
    //    }
    
    @objc func goalieDetails(sender: UIButton)  {
        
        //This replaces accessoryButtonTappedForRowWith
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        
        selectedGoalie = self.fetchedResultsController.object(at: indexPath as IndexPath)
        
        let goalieDetailsTableViewController = storyboard?.instantiateViewController(withIdentifier: "GoalieDetailsTableViewController") as! GoalieDetailsTableViewController
        
        goalieDetailsTableViewController.detailItem     = selectedGoalie
        
        //Set Nav back button
        backButtonNav.setBackButtonToBack(navItem: navigationItem)
        
        self.navigationController?.pushViewController(goalieDetailsTableViewController, animated: true)
        
    }
    
    @objc func goalieShotDetails(sender: UIButton)  {
        
        //This replaces accessoryButtonTappedForRowWith
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        
        selectedGoalie = self.fetchedResultsController.object(at: indexPath as IndexPath)
        
        let goalieGameDetailTableViewController = storyboard?.instantiateViewController(withIdentifier: "GoalieGameDetailTableViewController") as! GoalieGameDetailTableViewController
        
        goalieGameDetailTableViewController.goalie         = selectedGoalie
        goalieGameDetailTableViewController.managedContext = managedContext
        
        //Set Nav back button
        backButtonNav.setBackButtonToBack(navItem: navigationItem)
        
        self.navigationController?.pushViewController(goalieGameDetailTableViewController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if(editingStyle == .delete ) {
            
            let goalieToDelete = fetchedResultsController.object(at:indexPath)
            
            managedContext.delete(goalieToDelete)
            
            do {
                try managedContext.save()
                
                tableView.reloadData()
                
            } catch let error as NSError {
                print("GoalieInformationTableViewController|editingStyle: Saving error: \(error), description: \(error.userInfo)")
            }
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("didSelectRowAt")
        //
        //        let cell = tableView.cellForRow(at: indexPath) as! GoalieInformationTableViewCell
        //
        //        if cell.checkMarkImageView.isHidden {
        //
        //            cell.checkMarkImageView.isHidden = false
        //
        //            selectedRow = indexPath
        //
        //            selectedGoalie = self.fetchedResultsController.object(at: indexPath)
        //
        //            currentGoalieDelegate?.storeCurrentGoalie(currentGoalie: selectedGoalie!)
        //
        //        } else {
        //
        //            cell.checkMarkImageView.isHidden = true
        //
        //            selectedRow = nil
        //
        //            appDelegate.currentGoalie = nil
        //        }
        //
        //        //reloading the table will get rid of the checkmark if already selected.
        //        tableView.reloadData()
        //
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        //Don't allow deletion of cell that has a goalie in it.
        var returnValue: UITableViewCellEditingStyle?
        
        if appDelegate.leftGoalieIndex == indexPath || appDelegate.rightGoalieIndex == indexPath {
            
            returnValue = UITableViewCellEditingStyle.none
            
        } else {
            
            returnValue = UITableViewCellEditingStyle.delete
            
        }
        
        return returnValue!
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let goalieDetailsTableViewController = segue.destination as! GoalieDetailsTableViewController
        
        if segue.identifier == "newGoalieSegue" {
            
            //Set Nav back button
            backButtonNav.setBackButtonToBack(navItem: navigationItem)
            
            goalieDetailsTableViewController.managedContext = managedContext
            goalieDetailsTableViewController.newGoalie = true
            
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension GoalieInformationTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            
            tableView?.insertRows(at: [newIndexPath!], with: .automatic)
            
            tableView?.reloadData()  //Update Goalie Header count
            
        case .delete:
            
            tableView?.deleteRows(at: [indexPath!], with: .automatic)
            
            //reset the current goalie as it's been deleted.
            //            appDelegate.currentGoalie = nil
            
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
    
    
    func fetchShots(indexPath: IndexPath) -> (shots: String, goals: String, savePercentage:String) {
        
        let fetchRequest: NSFetchRequest<ShotDetails> = ShotDetails.fetchRequest()
        
        let selectedGoalieIndexPath = self.fetchedResultsController.object(at: indexPath)
        
        let predicate = NSPredicate(format: "goalieRelationship = %@", selectedGoalieIndexPath)
        
        let sort = NSSortDescriptor(key: #keyPath(ShotDetails.goalieRelationship), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.predicate = predicate
        fetchRequest.fetchBatchSize = 8
        
        do {
            shotsOnGoalie = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            
            print("GoalieInformationTableViewController|fetchShots: Could not fetch. \(error), \(error.userInfo)")
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
}

//extension GoalieInformationTableViewController: UpdateGoalieTableViewDelegate {
//    
//    func updateTable() {
//        
//        print("updateTable")
//        
////        self.tableView.reloadData()
//        
//    } //updateTable
//}  //extension

