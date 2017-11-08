//
//  StoreLastShot.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-11-04.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation

protocol storeLastShotsDelegate {
    
//    func storeLastRightShot(rightGoalieLastShot: ShotDetails)
//    func storeLastLeftShot(leftGoalieLastShot: ShotDetails)
    func storeLastShot(lastShot:[ShotDetails])
}
