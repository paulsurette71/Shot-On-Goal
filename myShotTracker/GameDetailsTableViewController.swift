//
//  GameDetailsTableViewController.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-02-10.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit
import CoreData

class GameDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var gameDatePicker: UIDatePicker!
    @IBOutlet weak var arenaCityTextField: UITextField!
    @IBOutlet weak var arenaNameTextField: UITextField!
    @IBOutlet weak var oppositionCityTextField: UITextField!
    @IBOutlet weak var oppositionTeamNameTextField: UITextField!
    @IBOutlet weak var shotDetailImageView: UIImageView!
    @IBOutlet weak var shotsLabel: UILabel!
    @IBOutlet weak var goalsLabel: UILabel!
    @IBOutlet weak var goalsAgainstForGoaliesLabel: UILabel!
    @IBOutlet weak var shotsForGoaliesLabel: UILabel!
    @IBOutlet weak var shotInformationLabel: UILabel!
    
    //App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //CoreData
    var managedContext: NSManagedObjectContext!
    
    var newGame = false
    var fetchShotsResults:[[String:AnyObject]]?
    var fetchGoalsResults:[[String:AnyObject]]?
    var shotsOnGoal:[[String:AnyObject]]?
    
    var totalShots = 0
    var totalGoals = 0
    var shotsString = ""
    var goalsString = ""
    
    //Classes
    let calculateSavePercentage = CalculateSavePercentage()
    let drawPuckScaled          = DrawPuckScaled()
    let goFetch = GoFetch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("2. viewDidLoad->GameDetailsTableViewController")
        
        //Move the TableView down a little bit.
        tableView.contentInset = UIEdgeInsets(top: 20.0, left: 0, bottom: 0, right: 0)
        
        configureView()
//        gameDetails()
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
//        if detailItem != nil {
//            return 4
//
//        } else {
//
          return 3
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 2
//        case 3:
//
//            if detailItem != nil {
//
//                var counter = 0
//
//                if let results = fetchShotsResults {
//
//                    print("results")
//                    counter = results.count
//
//                }
//
//                let index = IndexPath(item: 1, section: 3)
//                print("index \(index)")
//                
//
//                tableView.insertRows(at: [index], with: .automatic)
//
//                
//                tableView.reloadData()  //Update Game Header count
//                
//                print("fetchShotsResults \(counter)")
//                
//                return counter
//
//            } else {
//
//                return 0
//            }
            
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 15
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        //http://stackoverflow.com/questions/19802336/changing-font-size-for-uitableview-section-headers
        
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        header.textLabel?.textColor     = UIColor.black
        header.textLabel?.font          = UIFont.systemFont(ofSize: 17, weight: .heavy)
        header.textLabel?.frame         = header.frame
        header.textLabel?.textAlignment = .natural
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        //Check to see if the mandatory first name, last name and number are empty.
        guard !(arenaCityTextField.text?.isEmpty)!, !(arenaNameTextField.text?.isEmpty)!,!(oppositionCityTextField.text?.isEmpty)!,!(oppositionTeamNameTextField.text?.isEmpty)! else {
            //Found empty fields.
            return
        }
        
        if newGame {
            
            saveNewGame()
            
        } else {
            
            updateGame()
        }
    }
    
    func saveNewGame() {
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GameInformation", in: managedContext)
            let newGame = GameInformation(entity: entity!, insertInto: managedContext)
            
            newGame.gameDateTime       = gameDatePicker.date as NSDate?
            newGame.oppositionTeamName = oppositionTeamNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            newGame.oppositionCity     = oppositionCityTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            newGame.arenaCity          = arenaCityTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            newGame.arenaName          = arenaNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("GameDetailsTableViewController|saveNewGame: Fetch error: \(error) description: \(error.userInfo)")
        }
        
    }
    
    func updateGame() {
        
        do {
            let updateCurrentGame = detailItem
            
            updateCurrentGame?.gameDateTime       = gameDatePicker.date as NSDate?
            updateCurrentGame?.oppositionTeamName = oppositionTeamNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            updateCurrentGame?.oppositionCity     = oppositionCityTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            updateCurrentGame?.arenaName          = arenaNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            updateCurrentGame?.arenaCity          = arenaCityTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            try detailItem?.managedObjectContext?.save()
            
        } catch let error as NSError {
            print("GameDetailsTableViewController|updateGame: Fetch error: \(error) description: \(error.userInfo)")
        }
        
    }
    
    var detailItem: GameInformation? {
        
        didSet {
            
            self.configureView()
            
        }
    }
    
    func configureView() {
        
        // Update the user interface for the detail item.
        
        if let detail = self.detailItem {
            if let label = self.oppositionTeamNameTextField {
                label.text = detail.oppositionTeamName
            }
            if let picker = self.gameDatePicker {
                picker.date = detail.gameDateTime! as Date
            }
            if let label = self.oppositionCityTextField {
                label.text = detail.oppositionCity
            }
            if let label = self.arenaCityTextField {
                label.text = detail.arenaCity
            }
            if let label = self.arenaNameTextField {
                label.text = detail.arenaName
            }
        }
    }
    
//    func gameDetails() {
//
//        if detailItem != nil {
//
//            fetchShots()
//            fetchGoals()
//            fetchShotsforDrawing()
//
////            let result = goFetch.fetchGoaliesForGame(managedContext: managedContext, currentGame: detailItem!)
////            print("result \(result)")
//
//            for shotsOnGoal in fetchShotsResults!  {
//
//                //A goal is considered a shot
//                let shots = shotsOnGoal["countShots"]
//                totalShots += shots as! Int
//
//                let lastName = String(describing: shotsOnGoal["goalieRelationship.lastName"]!)
//                shotsString += String(describing: shots!) + " " + lastName + "\r"
//            }
//
//            for goalsScored in fetchGoalsResults! {
//
//                //A goal is considered a shot
//                let goals = goalsScored["countShots"]
//                totalGoals += goals as! Int
//
//                let lastName = String(describing: goalsScored["goalieRelationship.lastName"]!)
//                goalsString += String(describing: goals!) + " " + lastName + "\r"
//            }
//        }
//
//        //Change goals in string to red.
//        let numberOfGoalsAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: String(totalGoals))
//        numberOfGoalsAttributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSMakeRange(0, numberOfGoalsAttributedString.length))
//
//        let numberOfShotsAttributedString = NSMutableAttributedString(string: String(totalShots))
//        let savePercentageAttributedString = NSMutableAttributedString(string:calculateSavePercentage.calculateSavePercentage(shots: Double(totalShots), goals: Double(totalGoals)))
//
//        let combination = NSMutableAttributedString()
//        let pipeString = NSMutableAttributedString(string: "|")
//
//        combination.append(numberOfShotsAttributedString)
//        combination.append(pipeString)
//        combination.append(numberOfGoalsAttributedString)
//        combination.append(pipeString)
//        combination.append(savePercentageAttributedString)
//
//        shotInformationLabel.attributedText = combination
//        shotsForGoaliesLabel.text           = shotsString as String?
//        goalsAgainstForGoaliesLabel.text    = goalsString as String?
//
//    }
    
//    func fetchShots() {
//
//        //http://stackoverflow.com/questions/37306769/how-to-aggregate-in-swift
//
//        //select ZGOALIERELATIONSHIP, count(ZSHOTTYPE) from ZSHOTDETAILS where ZGAMERELATIONSHIP = 6 group by ZGOALIERELATIONSHIP;
//
//
//        let fetchRequest       = NSFetchRequest<NSFetchRequestResult>(entityName: "ShotDetails")
//        let predicate          = NSPredicate(format: "gameRelationship = %@", detailItem!)
//        fetchRequest.predicate = predicate
//        fetchRequest.fetchBatchSize = 8
//
//        //count(ZSHOTTYPE)
//        let countExpressionDesc                  = NSExpressionDescription()
//        countExpressionDesc.name                 = "countShots"
//        countExpressionDesc.expression           = NSExpression(forFunction: "count:", arguments: [NSExpression(forKeyPath: "shotType")])
//        countExpressionDesc.expressionResultType = .integer16AttributeType
//
//        fetchRequest.propertiesToGroupBy = [#keyPath(ShotDetails.goalieRelationship.firstName), #keyPath(ShotDetails.goalieRelationship.lastName)]
//        fetchRequest.propertiesToFetch   = [#keyPath(ShotDetails.goalieRelationship.firstName), #keyPath(ShotDetails.goalieRelationship.lastName), countExpressionDesc]
//        fetchRequest.resultType          = .dictionaryResultType
//
//        do {
//
//            fetchShotsResults = try managedContext.fetch(fetchRequest) as? [[String:AnyObject]]
////            print("fetchShotsResults \(fetchShotsResults!)")
//
//        } catch let error as NSError {
//
//            print("GameDetailsTableViewController|fetchShots: Could not fetch. \(error), \(error.userInfo)")
//        }
//    }
    
//    func fetchGoals() {
//
//        //http://stackoverflow.com/questions/37306769/how-to-aggregate-in-swift
//
//        //select ZGOALIERELATIONSHIP, count(ZSHOTTYPE) from ZSHOTDETAILS where ZGAMERELATIONSHIP = 6 group by ZGOALIERELATIONSHIP;
//
//
//        let fetchRequest       = NSFetchRequest<NSFetchRequestResult>(entityName: "ShotDetails")
//        let predicate          = NSPredicate(format: "gameRelationship = %@ AND shotType = 'goal'", detailItem!)
//        fetchRequest.predicate = predicate
//        fetchRequest.fetchBatchSize = 8
//
//        //count(ZSHOTTYPE)
//        let countExpressionDesc                  = NSExpressionDescription()
//        countExpressionDesc.name                 = "countShots"
//        countExpressionDesc.expression           = NSExpression(forFunction: "count:", arguments: [NSExpression(forKeyPath: "shotType")])
//        countExpressionDesc.expressionResultType = .integer16AttributeType
//
//        fetchRequest.propertiesToGroupBy = [#keyPath(ShotDetails.goalieRelationship.lastName)]
//        fetchRequest.propertiesToFetch   = [#keyPath(ShotDetails.goalieRelationship.lastName), countExpressionDesc]
//        fetchRequest.resultType          = .dictionaryResultType
//
//        do {
//
//            fetchGoalsResults = try managedContext.fetch(fetchRequest) as? [[String:AnyObject]]
//
//        } catch let error as NSError {
//
//            print("GameDetailsTableViewController|fetchGoals: Could not fetch. \(error), \(error.userInfo)")
//        }
//    }
    
    
//    func fetchShotsforDrawing() {
//
//        //select ZGOALIERELATIONSHIP, ZSHOTLOCATION from ZSHOTDETAILS where ZGAMERELATIONSHIP = 5;
//
//        let fetchRequest       = NSFetchRequest<NSFetchRequestResult>(entityName: "ShotDetails")
//        let predicate          = NSPredicate(format: "gameRelationship = %@", detailItem!)
//        fetchRequest.predicate = predicate
//        fetchRequest.fetchBatchSize = 8
//
//        fetchRequest.propertiesToFetch   = [#keyPath(ShotDetails.shotLocation),#keyPath(ShotDetails.shotType),#keyPath(ShotDetails.shotNumber)]
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
//                drawPuckScaled.drawPuck(location: shots["shotLocation"] as! CGPoint, view: shotDetailImageView, colour: UIColor.black.cgColor, shotNumber: String(describing: shots["shotNumber"]!))
//
//            } else {
//
//                drawPuckScaled.drawPuck(location: shots["shotLocation"] as! CGPoint, view: shotDetailImageView, colour: UIColor.red.cgColor, shotNumber: String(describing: shots["shotNumber"]!))
//
//            }
//        }
//    }
    
//    func fetchGoalies() {
//
//
//    }  //fetchGoalies
    
}
