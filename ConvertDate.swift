//
//  ConvertDate.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-02-23.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation

class ConvertDate {
    
    func convertDate(date:NSDate) -> String {
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = DateFormatter.Style.medium
        
        return formatter.string(from: date as Date)
    }
    
}
