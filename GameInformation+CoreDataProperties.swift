//
//  GameInformation+CoreDataProperties.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-04-11.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import CoreData


extension GameInformation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameInformation> {
        return NSFetchRequest<GameInformation>(entityName: "GameInformation")
    }

    @NSManaged public var arenaCity: String?
    @NSManaged public var arenaName: String?
    @NSManaged public var gameDateTime: NSDate?
    @NSManaged public var gameNumber: String?
    @NSManaged public var oppositionCity: String?
    @NSManaged public var oppositionTeamName: String?
    @NSManaged public var gameToShotRelationship: NSSet?

}

// MARK: Generated accessors for gameToShotRelationship
extension GameInformation {

    @objc(addGameToShotRelationshipObject:)
    @NSManaged public func addToGameToShotRelationship(_ value: ShotDetails)

    @objc(removeGameToShotRelationshipObject:)
    @NSManaged public func removeFromGameToShotRelationship(_ value: ShotDetails)

    @objc(addGameToShotRelationship:)
    @NSManaged public func addToGameToShotRelationship(_ values: NSSet)

    @objc(removeGameToShotRelationship:)
    @NSManaged public func removeFromGameToShotRelationship(_ values: NSSet)

}
