//
//  GoalieInformationTableViewCell.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-03-04.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit

class GoalieInformationTableViewCell: UITableViewCell {
    
    //ImageView
    @IBOutlet weak var goalieHeadShotImageView: UIImageView!
    
    //Labels
    @IBOutlet weak var goalieInformationLabel: UILabel!
    @IBOutlet weak var shotInformationLabel: UILabel!
    
    @IBOutlet weak var goalieTeamInformation: UILabel!
    
    //Button
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var chevronButton: UIButton!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    
}
