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
    
    
    
    
}  //GoFetch
