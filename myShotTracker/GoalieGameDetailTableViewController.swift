//
//  GoalieGameDetailTableViewController.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-03-08.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit
import CoreData

class GoalieGameDetailTableViewController: UITableViewController {
    
    //CoreData
    var managedContext: NSManagedObjectContext!
    var goalie: GoalieInformation?
    var resultsArray = [Any]()
    var getShotsArray = [Any]()
    var getGoalsArray = [Any]()
    var currentGameForSegue:Any?
    
    //JPEG Compresion
    let bestQuality:CGFloat = 1.0
    
    //Classes
    let convertDate                   = ConvertDate()
    let calculateSavePercentage       = CalculateSavePercentage()
    let backButtonNav                 = BackButtonNav()
    let goalieDetailsAttributedString = GoalieDetailsAttributedString()
    let gameDateAttribString          = GameDateAttribString()
    let formatShotGoalPercentageAttributedString = FormatShotGoalPercentageAttributedString()
    
    var returnString:NSAttributedString? = nil
    var combination = NSMutableAttributedString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("2. viewDidLoad->GoalieGameDetailTableViewController")
        
        //Setup Custom NIB
        let cellNib = UINib(nibName: "GameInformationTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "gameCell")
        tableView.rowHeight = 82
        tableView.allowsSelection = false
        
        showGoalieInfoInNav()
        fetchGameInformation()  //crash
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resultsArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return  "Games " + String(resultsArray.count)
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameInformationTableViewCell
        
        cell.selectionStyle = .none
        cell.chevronButton.tag = indexPath.row
        cell.chevronButton.addTarget(self, action: #selector(gameDetails), for: .touchUpInside)
        
        let formattedDate = (resultsArray[indexPath.row] as AnyObject).value(forKey: "gameRelationship.gameDateTime")
        
        let gameDate = convertDate.convertDate(date: (formattedDate)! as! NSDate)
        
        let vsCity = (resultsArray[indexPath.row] as AnyObject).value(forKey: "gameRelationship.oppositionCity")
        let vsTeamName = (resultsArray[indexPath.row] as AnyObject).value(forKey: "gameRelationship.oppositionTeamName")
        
        returnString = gameDateAttribString.gameDateAtrib(curentDate: gameDate, oppositionCity:  vsCity! as! String, oppositionTeamName: vsTeamName! as! String)
        
        
        let shots = getShotsArray[indexPath.row] as! Int
        let goals = getGoalsArray[indexPath.row] as! Int
        
        
        cell.gameInformationLabel.attributedText = returnString
        cell.shotInformationLabel.attributedText = formatShotGoalPercentageAttributedString.formattedString(shots: shots, goals: goals, fontSize: 17)

        
        return cell
    }
    
    @objc func gameDetails(sender: UIButton)  {
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        currentGameForSegue = (resultsArray[indexPath.row] as AnyObject).value(forKey: "gameRelationship")!
        
        let shotInformation = tableView.cellForRow(at: indexPath as IndexPath) as! GameInformationTableViewCell
        
        //Set Nav back button
        backButtonNav.setBackButtonToBack(navItem: navigationItem)
        
        //This is used to pass the date to the periodGameDetailViewController for the title. - November 21st, 2017
        let formattedDate = (resultsArray[indexPath.row] as AnyObject).value(forKey: "gameRelationship.gameDateTime")
        let gameDate = convertDate.convertDate(date: (formattedDate)! as! NSDate)
        let vsCity = (resultsArray[indexPath.row] as AnyObject).value(forKey: "gameRelationship.oppositionCity")
        let vsTeamName = (resultsArray[indexPath.row] as AnyObject).value(forKey: "gameRelationship.oppositionTeamName")
        
        let gameDateStringForTitle = gameDateAttribString.gameDateAtrib(curentDate: gameDate, oppositionCity: vsCity as! String, oppositionTeamName: vsTeamName as! String)
        
        let periodGameDetailViewController = storyboard?.instantiateViewController(withIdentifier: "PeriodGameDetailViewController") as! PeriodGameDetailViewController
        
        periodGameDetailViewController.dateStringForTitle = gameDateStringForTitle
        periodGameDetailViewController.goalie             = goalie
        periodGameDetailViewController.managedContext     = managedContext
        periodGameDetailViewController.shotInformation    = shotInformation.shotInformationLabel.attributedText as! NSMutableAttributedString
        periodGameDetailViewController.game               = currentGameForSegue!
        
        
        self.navigationController?.pushViewController(periodGameDetailViewController, animated: true)
        
    }
    
    func showGoalieInfoInNav () {
        
        guard (goalie != nil) else {
            return
        }
        
        let attribTitle = goalieDetailsAttributedString.goalieDetailInformation(number: (goalie?.number)!, firstName: (goalie?.firstName)!, lastName: (goalie?.lastName)!)
        
        let titleLabel = UILabel()
        titleLabel.attributedText = attribTitle
        self.navigationItem.titleView = titleLabel
    }
    
    func fetchGameInformation() {
        
        //http://stackoverflow.com/questions/37306769/how-to-aggregate-in-swift
        
        
        let fetchRequest       = NSFetchRequest<NSFetchRequestResult>(entityName: "ShotDetails")
        let predicate          = NSPredicate(format: "goalieRelationship = %@", goalie!)
        fetchRequest.predicate = predicate
        fetchRequest.fetchBatchSize = 8
        
        
        //April 10th update sort by Date
        let sort = NSSortDescriptor(key: #keyPath(ShotDetails.gameRelationship.gameDateTime), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        fetchRequest.propertiesToGroupBy = [#keyPath(ShotDetails.gameRelationship), #keyPath(ShotDetails.gameRelationship.gameDateTime), #keyPath(ShotDetails.gameRelationship.oppositionCity), #keyPath(ShotDetails.gameRelationship.oppositionTeamName)]
        fetchRequest.propertiesToFetch   = [#keyPath(ShotDetails.gameRelationship), #keyPath(ShotDetails.gameRelationship.gameDateTime), #keyPath(ShotDetails.gameRelationship.oppositionCity), #keyPath(ShotDetails.gameRelationship.oppositionTeamName)]
        fetchRequest.resultType          = .dictionaryResultType
        
        do {
            
            resultsArray = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            
            print("GoalieGameDetailTableViewController|fetchGameInformation: Could not fetch. \(error), \(error.userInfo)")
        }
        
        guard resultsArray.count != 0 else {
            
            //No need to fetch more data if there are no shots or games recorded.
            return
        }
        
        fectchGoals()
        fectchShots()
    }
    
    func fectchGoals() {
        
        guard resultsArray.count != 0 else {
            return
        }
        
        for results in resultsArray {
            
            //App Crashes??
            
            let currentGame = (results as AnyObject).value(forKey: "gameRelationship")
            
            let fetchRequest       = NSFetchRequest<NSFetchRequestResult>(entityName: "ShotDetails")
            let currentGoalie      = NSPredicate(format: "goalieRelationship = %@", goalie!)
            let predicate          = NSPredicate(format: "gameRelationship = %@", currentGame! as! CVarArg)
            let goalPredicate      = NSPredicate(format: "shotType = 'goal'")
            
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [currentGoalie,predicate,goalPredicate ])
            
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.fetchBatchSize = 8
            
            do {
                
                let goalResults = try managedContext.fetch(fetchRequest)
                getGoalsArray.append(goalResults.count)
                
            } catch let error as NSError {
                
                print("GoalieGameDetailTableViewController|fectchGoals: Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func fectchShots() {
        
        guard resultsArray.count != 0 else {
            return
        }
        
        for results in resultsArray {
            
            let currentGame = (results as AnyObject).value(forKey: "gameRelationship")
            
            let fetchRequest       = NSFetchRequest<NSFetchRequestResult>(entityName: "ShotDetails")
            let currentGoalie      = NSPredicate(format: "goalieRelationship = %@", goalie!)
            let predicate          = NSPredicate(format: "gameRelationship = %@", currentGame! as! CVarArg)
            
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [currentGoalie,predicate])
            
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.fetchBatchSize = 8
            
            do {
                
                let shotResults = try managedContext.fetch(fetchRequest)
                getShotsArray.append(shotResults.count)
                
            } catch let error as NSError {
                
                print("GoalieGameDetailTableViewController|fectchShots: Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
}

