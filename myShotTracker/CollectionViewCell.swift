//
//  CollectionViewCell.swift
//  Shot On Goal v2
//
//  Created by Surette, Paul on 2017-10-05.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var hockeyNetImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print("CollectionViewCell awakeFromNib")
        
    }
}
