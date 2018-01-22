//
//  UpdateGame.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-11-01.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class UpdateGame {
    
    //Delegate
    var lastShot: storeLastShotsDelegate?
    
    var lastShotArray = [ShotDetails]()
    
    func withMyCurrentShots(managedContext: NSManagedObjectContext, currentGame: GameInformation, goalie:GoalieInformation, shotArray: [ShotInfo]) {
        
        do {
            
            //Current Game
            
            let entity  = NSEntityDescription.entity(forEntityName: "ShotDetails", in: managedContext)
            let newShot = ShotDetails(entity: entity!, insertInto: managedContext)
            
            newShot.gameRelationship   = currentGame
            newShot.goalieRelationship = goalie
            
            let shot = shotArray.last            
            let shotNumberInt = shot?.shotNumber
            
            newShot.shotLocation    = shot?.location as NSObject?
            newShot.shotNumber      = Int16(shotNumberInt!)
            newShot.shotType        = (shot?.result).map { $0.rawValue }
            newShot.shotPeriod      = (shot?.period).map { $0.rawValue }
            newShot.shotDate        = shot?.timeOfShot as NSDate?
            
            lastShotArray.append(newShot)
            lastShot?.storeMyLastShot(myLastShot: lastShotArray)

            try managedContext.save()
            
        } catch let error as NSError {
            print("\(self) -> \(#function) \(error), \(error.userInfo)")
        }
        
    }  //withCurrentShots
    
    
    func withTheirCurrentShots(managedContext: NSManagedObjectContext, currentGame: GameInformation, goalie:GoalieInformation, shotArray: [ShotInfo]) {
        
        do {
            
            //Current Game
            
            let entity  = NSEntityDescription.entity(forEntityName: "ShotDetails", in: managedContext)
            let newShot = ShotDetails(entity: entity!, insertInto: managedContext)
            
            newShot.gameRelationship   = currentGame
            newShot.goalieRelationship = goalie
            
            let shot = shotArray.last
            let shotNumberInt = shot?.shotNumber
            
            newShot.shotLocation    = shot?.location as NSObject?
            newShot.shotNumber      = Int16(shotNumberInt!)
            newShot.shotType        = (shot?.result).map { $0.rawValue }
            newShot.shotPeriod      = (shot?.period).map { $0.rawValue }
            newShot.shotDate        = shot?.timeOfShot as NSDate?
            
            lastShotArray.append(newShot)
            lastShot?.storeTheirLastShot(theirLastShot: lastShotArray)
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("\(self) -> \(#function) \(error), \(error.userInfo)")
        }
        
    }  //withCurrentShots

}  //UpdateGame

