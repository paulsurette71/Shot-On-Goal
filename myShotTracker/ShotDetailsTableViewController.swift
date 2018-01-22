//
//  ShotDetailsTableViewController.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-24.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit

class ShotDetailsTableViewController: UITableViewController {
    
    let formatShotGoalPercentageAttributedString = FormatShotGoalPercentageAttributedString()
    
    //Data passed
    var sender: UIButton?
    var mainView: MainView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func convertDateToString(dateToConvert:Date) -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = .medium  //10:00:00 PM
        
        let dateAsAString = dateFormatter.string(from: dateToConvert)
        let dateAsADate   = dateFormatter.date(from: dateAsAString)
        let convertedDateAsAString = dateFormatter.string(from: dateAsADate!)
        
        return convertedDateAsAString
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
        
        if sender == mainView?.leftShotDetailsButton {
            
            returnValue = GlobalVariables.myShotArray.count
            
        } else if sender == mainView?.rightShotDetailsButton {
            
            returnValue = GlobalVariables.theirShotArray.count
            
        }
        
        return returnValue
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("ShotInformationTableViewCell", owner: self, options: nil)?.first as! ShotInformationTableViewCell
        
        var positionInArray: ShotInfo?
        
        if sender == mainView?.leftShotDetailsButton {
            
            positionInArray = GlobalVariables.myShotArray[indexPath.row]
            
        } else if sender == mainView?.rightShotDetailsButton {
            
            positionInArray = GlobalVariables.theirShotArray[indexPath.row]
            
        }
        
        let shotNumber = positionInArray?.shotNumber
        let shotTime   = convertDateToString(dateToConvert: (positionInArray?.timeOfShot)!)
        
        cell.myGoalieShotInformationShotNumberLabel.text     = String(describing: shotNumber!)
        cell.myGoalieShotInformationTimeLabel.text           = shotTime
        cell.myGoalieShotInformationTimeDifferenceLabel.text = positionInArray?.timeDifference.stringTime
        cell.myGoalieShotInformationPeriodLabel.text         = positionInArray?.period.rawValue
        
        if positionInArray?.result == .shot {
            
            cell.myGoalieShotCircleImageView.image = UIImage(named: "Shot Circle")  //Black
            
        } else {
            
            cell.myGoalieShotCircleImageView.image = UIImage(named: "Goal Circle")  //Red
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        //http://stackoverflow.com/questions/19802336/changing-font-size-for-uitableview-section-headers
        
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
                
        if sender == mainView?.leftShotDetailsButton {
            view.tintColor = UIColor(named: "hockeyNetRed")
        } else {
            view.tintColor = UIColor(named: "blue")
        }
        
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var heading = ""
        
        if sender == mainView?.leftShotDetailsButton {
            
            heading = "Shots \(GlobalVariables.myShotsOnNet) Goals \(GlobalVariables.myGoals)"
            
        } else if sender == mainView?.rightShotDetailsButton {
            
            heading = "Shots \(GlobalVariables.theirShotsOnNet) Goals \(GlobalVariables.theirGoals)"
            
        }
        
        return heading
        
    }
    
}

extension TimeInterval {
    
    //https://stackoverflow.com/review/suggested-edits/16940597
    
    private var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }
    
    private var seconds: Int {
        return Int(self) % 60
    }
    
    private var minutes: Int {
        return (Int(self) / 60 ) % 60
    }
    
    private var hours: Int {
        return Int(self) / 3600
    }
    
    var stringTime: String {
        if hours != 0 {
            return "\(hours)h \(minutes)m \(seconds)s"
        } else if minutes != 0 {
            return "\(minutes)m \(seconds)s"
        } else if milliseconds != 0 {
            return "\(seconds)s \(milliseconds)ms"
        } else {
            return "\(seconds)s"
        }
    }
}
