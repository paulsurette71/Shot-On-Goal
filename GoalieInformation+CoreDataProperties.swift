//
//  GoalieInformation+CoreDataProperties.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-04-11.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import CoreData


extension GoalieInformation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GoalieInformation> {
        return NSFetchRequest<GoalieInformation>(entityName: "GoalieInformation")
    }

    @NSManaged public var city: String?
    @NSManaged public var divisionName: String?
    @NSManaged public var dob: NSDate?
    @NSManaged public var firstName: String?
    @NSManaged public var goalieHeadShot: NSData?
    @NSManaged public var height: String?
    @NSManaged public var lastName: String?
    @NSManaged public var leagueName: String?
    @NSManaged public var level: String?
    @NSManaged public var number: String?
    @NSManaged public var shoots: String?
    @NSManaged public var teamName: String?
    @NSManaged public var weight: String?
    @NSManaged public var goalieToShotRelationship: NSSet?

}

// MARK: Generated accessors for goalieToShotRelationship
extension GoalieInformation {

    @objc(addGoalieToShotRelationshipObject:)
    @NSManaged public func addToGoalieToShotRelationship(_ value: ShotDetails)

    @objc(removeGoalieToShotRelationshipObject:)
    @NSManaged public func removeFromGoalieToShotRelationship(_ value: ShotDetails)

    @objc(addGoalieToShotRelationship:)
    @NSManaged public func addToGoalieToShotRelationship(_ values: NSSet)

    @objc(removeGoalieToShotRelationship:)
    @NSManaged public func removeFromGoalieToShotRelationship(_ values: NSSet)

}
