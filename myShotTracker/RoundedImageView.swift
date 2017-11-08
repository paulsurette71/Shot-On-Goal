//
//  RoundedImageView.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-03-01.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class RoundedImageView: UIImageView {
    
    //Clsses
//    let colourPalette = ColourPalette()
    
    func setRounded(image: UIImageView) {
        
        //http://stackoverflow.com/questions/28074679/how-to-set-image-in-circle-in-swift
        
        image.layer.borderWidth = 2
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor(named: "hockeyNetRed")?.cgColor 
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        
    }
}
