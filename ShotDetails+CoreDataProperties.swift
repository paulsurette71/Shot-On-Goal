//
//  ShotDetails+CoreDataProperties.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-04-11.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import CoreData


extension ShotDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShotDetails> {
        return NSFetchRequest<ShotDetails>(entityName: "ShotDetails")
    }

    @NSManaged public var advancedShotDifficulty: Int16
    @NSManaged public var advancedShotDistance: Int16
    @NSManaged public var advancedShotLocation: NSObject?
    @NSManaged public var shotDate: NSDate?
    @NSManaged public var shotLocation: NSObject?
    @NSManaged public var shotNumber: Int16
    @NSManaged public var shotPeriod: String?
    @NSManaged public var shotScoreClock: String?
    @NSManaged public var shotType: String?
    @NSManaged public var advancedMode: Bool
    @NSManaged public var gameRelationship: GameInformation?
    @NSManaged public var goalieRelationship: GoalieInformation?

}
