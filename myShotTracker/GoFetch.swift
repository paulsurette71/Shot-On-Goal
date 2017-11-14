//
//  GoFetch.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-11-05.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import CoreData

class GoFetch {
    
    func fetchGoaliesForGame(managedContext: NSManagedObjectContext, currentGame: GameInformation) -> [Any] {
        
        var fetchGoalieForGame = [Any]()
        
        print("class->GoFetch->fetchGoaliesForGame")
        
        let fetchRequest            = NSFetchRequest<NSFetchRequestResult>(entityName: "ShotDetails")
        let predicate               = NSPredicate(format: "gameRelationship = %@", currentGame)
        fetchRequest.predicate      = predicate
        fetchRequest.fetchBatchSize = 8
        
        //        fetchRequest.propertiesToFetch = [goalie]
        
        fetchRequest.propertiesToGroupBy = [#keyPath(ShotDetails.goalieRelationship.number),#keyPath(ShotDetails.goalieRelationship.firstName), #keyPath(ShotDetails.goalieRelationship.lastName)]
        fetchRequest.propertiesToFetch   = [#keyPath(ShotDetails.goalieRelationship.number),#keyPath(ShotDetails.goalieRelationship.firstName), #keyPath(ShotDetails.goalieRelationship.lastName)]
        fetchRequest.resultType          = .dictionaryResultType
        
        do {
            
            fetchGoalieForGame = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            
            print("GoFetch|fetchGoaliesForGame: Could not fetch. \(error), \(error.userInfo)")
        }
        
        return fetchGoalieForGame
    }
    
    func fectchShots(goalie:GoalieInformation, game:Any, managedContext:NSManagedObjectContext) -> [ShotDetails] {
        
        //select ZSHOTPERIOD, ZSHOTTYPE, count(*) from ZSHOTDETAILS where ZGAMERELATIONSHIP = 1 and ZGOALIERELATIONSHIP = 3 GROUP BY ZSHOTPERIOD, ZSHOTTYPE;
        
        var shotResults = [ShotDetails]()
        
        let fetchRequest: NSFetchRequest<ShotDetails> = ShotDetails.fetchRequest()
        let currentGoalie      = NSPredicate(format: "goalieRelationship = %@", goalie)
        let predicate          = NSPredicate(format: "gameRelationship = %@", game as! CVarArg)
        
        fetchRequest.predicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [currentGoalie,predicate])
        fetchRequest.fetchBatchSize = 8
        
        do {
            
            shotResults =  try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            
            print("GoFetch|fectchShots: Could not fetch. \(error), \(error.userInfo)")
        }
        
        return shotResults
    }
    
    func fectchPeriods(goalie:GoalieInformation, game:Any, managedContext:NSManagedObjectContext) -> [Any] {
        
        //select ZSHOTPERIOD from ZSHOTDETAILS where ZGAMERELATIONSHIP = 1 and ZGOALIERELATIONSHIP =1 group by ZSHOTPERIOD;
        
        var numberOfPeriodsResults = [Any]()
        
        let fetchRequest       = NSFetchRequest<NSFetchRequestResult>(entityName: "ShotDetails")
        let currentGoalie      = NSPredicate(format: "goalieRelationship = %@", goalie)
        let predicate          = NSPredicate(format: "gameRelationship = %@", game as! CVarArg)
        
        fetchRequest.propertiesToGroupBy = [#keyPath(ShotDetails.shotPeriod)]
        fetchRequest.propertiesToFetch   = [#keyPath(ShotDetails.shotPeriod)]
        fetchRequest.resultType          = .dictionaryResultType
        
        fetchRequest.predicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [currentGoalie,predicate])
        fetchRequest.fetchBatchSize = 8
        
        do {
            
            numberOfPeriodsResults = try managedContext.fetch(fetchRequest)
            
            let gameSection = ["shotPeriod":"Game"]
            numberOfPeriodsResults.insert(gameSection, at: 0)
            
        } catch let error as NSError {
            
            print("GoFetch|fectchPeriods: Could not fetch. \(error), \(error.userInfo)")
        }
        
        return numberOfPeriodsResults
        
    }  //func fectchPeriods
    
    func fetchNumberOfGoalies(managedContext:NSManagedObjectContext) -> Int {
        
        var numberOfGoalies = 0
        
        //select ZSHOTPERIOD from ZSHOTDETAILS where ZGAMERELATIONSHIP = 1 and ZGOALIERELATIONSHIP =1 group by ZSHOTPERIOD;
        
        let fetchRequest        = NSFetchRequest<NSFetchRequestResult>(entityName: "GoalieInformation")
        fetchRequest.resultType = .dictionaryResultType
        
        do {
            
            let numberOfPeriodsResults = try managedContext.fetch(fetchRequest)
            numberOfGoalies = numberOfPeriodsResults.count
            
        } catch let error as NSError {
            
            print("GoFetch|fetchNumberOfGoalies: Could not fetch. \(error), \(error.userInfo)")
        }
        
        return numberOfGoalies

    }
    
}  //GoFetch
