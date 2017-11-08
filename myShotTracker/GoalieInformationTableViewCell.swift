//
//  GoalieInformationTableViewCell.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-02-02.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit

class GoalieInformationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var goalieNumberLabel: UILabel!
    @IBOutlet weak var goalieNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
