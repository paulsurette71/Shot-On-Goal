//
//  PeriodGameDetailViewController.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-03-17.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit
import CoreData

class PeriodGameDetailViewController: UIViewController {
    
    @IBOutlet weak var headShotImageView: UIImageView!
    @IBOutlet weak var playerInfomationLabel: UILabel!
    @IBOutlet weak var shotInformationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let shareAction = ShareAction()
    
    //CoreData
    var managedContext: NSManagedObjectContext!
    var goalie: GoalieInformation?
    var game: Any?
    var shotPeriod    = ""
    var currentPeriod = ""
    
    var shareActionArray = [Any]()
    
    //Date
    var dateStringForTitle:NSAttributedString? = nil
    
    var shotInformation    = NSMutableAttributedString()
    
    //Classes
    let roundedImageView                         = RoundedImageView()
    let calculateSavePercentage                  = CalculateSavePercentage()
    let drawPuckScaled                           = DrawPuckScaled()
    let backButtonNav                            = BackButtonNav()
    let goalieDetailsAttributedString            = GoalieDetailsAttributedString()
    let formatShotGoalPercentageAttributedString = FormatShotGoalPercentageAttributedString()
    
    //Fetch Results
    var shotResults = [ShotDetails]()
    var numberOfPeriodsResults = [Any]()
    
    //Counters
    var goalCount = 0
    var shotCount = 0
    
    let bezierPath = UIBezierPath()
    var shapeLayer = CAShapeLayer()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fectchShots()
        fectchPeriods()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("4. viewDidLoad->PeriodGameDetailViewController")
        
        showGoalieInfoInNav()
        addNavBarButton()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNib()
        
    }
    
    func addNavBarButton() {
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showActivityViewController))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    @objc func showActivityViewController() {
        
        let goalieNetImagesArray = shareAction.gatherData(shotInformation: shotResults, periodInformation: numberOfPeriodsResults)
        
        let resultsArray = shareAction.buildMessage(goalie: goalie!, dateStringForTitle: dateStringForTitle!, goalieNetArray: goalieNetImagesArray )
        
        let activityViewController = UIActivityViewController(activityItems: resultsArray, applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
        
    }
    
    func showGoalieInfoInNav () {
        
        let titleLabel = UILabel()
        titleLabel.attributedText = dateStringForTitle
        self.navigationItem.titleView = titleLabel
    }
    
    func setupNib() {
        
        //Setup Custom NIB
        let netNib = UINib(nibName: "PeriodGameDetailTableViewCell", bundle: nil)
        
        tableView.register(netNib, forCellReuseIdentifier: "perodGameDetailCell")
        tableView.rowHeight       = 260 //435 //250
        tableView.allowsSelection = false
    }
    
    func fectchShots() {
        
        //select ZSHOTPERIOD, ZSHOTTYPE, count(*) from ZSHOTDETAILS where ZGAMERELATIONSHIP = 1 and ZGOALIERELATIONSHIP = 3 GROUP BY ZSHOTPERIOD, ZSHOTTYPE;
        
        let fetchRequest: NSFetchRequest<ShotDetails> = ShotDetails.fetchRequest()
        let currentGoalie      = NSPredicate(format: "goalieRelationship = %@", goalie!)
        let predicate          = NSPredicate(format: "gameRelationship = %@", game! as! CVarArg)
        
        fetchRequest.predicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [currentGoalie,predicate])
        fetchRequest.fetchBatchSize = 8
        
        do {
            
            shotResults = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            
            print("PeriodGameDetailTableViewController|fectchShots: Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fectchPeriods() {
        
        //select ZSHOTPERIOD from ZSHOTDETAILS where ZGAMERELATIONSHIP = 1 and ZGOALIERELATIONSHIP =1 group by ZSHOTPERIOD;
        
        
        let fetchRequest       = NSFetchRequest<NSFetchRequestResult>(entityName: "ShotDetails")
        let currentGoalie      = NSPredicate(format: "goalieRelationship = %@", goalie!)
        let predicate          = NSPredicate(format: "gameRelationship = %@", game! as! CVarArg)
        
        fetchRequest.propertiesToGroupBy = [#keyPath(ShotDetails.shotPeriod)]
        fetchRequest.propertiesToFetch   = [#keyPath(ShotDetails.shotPeriod)]
        fetchRequest.resultType          = .dictionaryResultType
        
        fetchRequest.predicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [currentGoalie,predicate])
        fetchRequest.fetchBatchSize = 8
        
        do {
            
            numberOfPeriodsResults = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            
            print("PeriodGameDetailTableViewController|fectchPeriods: Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

extension PeriodGameDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return numberOfPeriodsResults.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        //http://stackoverflow.com/questions/19802336/changing-font-size-for-uitableview-section-headers
        
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "perodGameDetailCell", for: indexPath) as! PeriodGameDetailTableViewCell
        
        cell.selectionStyle = .none
        cell.hockeyNetImageView.contentMode = .scaleAspectFit
        cell.hockeyNetImageView.layer.sublayers?.removeAll()
        
        shotCount = 0
        goalCount = 0
        
        let period = (numberOfPeriodsResults[indexPath.section] as AnyObject).value(forKey: "shotPeriod") as! String
        
        currentPeriod = period
        
        for shots in shotResults {
            
            let shotOrGoal = shots.shotType
            
            shotPeriod = shots.shotPeriod!
            
            if period == shotPeriod {
                
                if shotOrGoal == "shot" {
                    
                    shotCount += 1
                    
                    drawPuckScaled.drawPuck(location: shots.shotLocation as! CGPoint, view: cell.hockeyNetImageView, colour: UIColor.black.cgColor, shotNumber: String(shots.shotNumber))
                    
                    
                } else {
                    
                    goalCount += 1
                    
                    drawPuckScaled.drawPuck(location: shots.shotLocation as! CGPoint, view: cell.hockeyNetImageView, colour: UIColor.red.cgColor, shotNumber: String(shots.shotNumber))
                    
                }
            }
        }
        
        cell.shotGoalDetailLabel.attributedText = formatShotGoalPercentageAttributedString.formattedString(shots: shotCount, goals: goalCount, fontSize: 24)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let sectionTitle = (numberOfPeriodsResults[section] as AnyObject).value(forKey: "shotPeriod") as! String
        
        return sectionTitle
    }
}

