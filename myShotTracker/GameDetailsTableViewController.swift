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
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
          return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 2
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
}
