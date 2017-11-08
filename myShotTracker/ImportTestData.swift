//
//  ImportTestData.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-03-18.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ImportTestData {
    
    //App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func importGoalies() {
        
        let managedContext = appDelegate.coreDataStack.managedContext
        
        //import 20 goalies
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GoalieInformation", in: managedContext)
            let newGoalie = GoalieInformation(entity: entity!, insertInto: managedContext)
            
            newGoalie.firstName    = "Sergei"
            newGoalie.lastName     = "Bobrovsky"
            newGoalie.number       = "72"
            newGoalie.city         = "Columbus"
            newGoalie.teamName     = "Blue Jackets"
            newGoalie.leagueName   = "NHL"
            newGoalie.divisionName = "Metropolitan"
            newGoalie.level        = "Professional"
            newGoalie.height       = "6'2\""
            newGoalie.weight       = "182 lb"
            
            //HeadShot
            let goalieImage = UIImageJPEGRepresentation(UIImage(named: "Bobrovsky.png")!, 1.0) as NSData?
            
            newGoalie.goalieHeadShot = goalieImage
            
            //Store Birthdate
            let dateString           = "1988-09-20"
            let dateFormatter        = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            newGoalie.dob          = date as NSDate?
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("ImportTestData|importGoalies: Fetch error: \(error) description: \(error.userInfo)")
        }
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GoalieInformation", in: managedContext)
            let newGoalie = GoalieInformation(entity: entity!, insertInto: managedContext)
            
            newGoalie.firstName    = "Devan"
            newGoalie.lastName     = "Dubnyk"
            newGoalie.number       = "40"
            newGoalie.city         = "Minnesota"
            newGoalie.teamName     = "Wild"
            newGoalie.leagueName   = "NHL"
            newGoalie.divisionName = "Central"
            newGoalie.level        = "Professional"
            newGoalie.height       = "6'6\""
            newGoalie.weight       = "213 lb"
            
            //HeadShot
            let goalieImage = UIImageJPEGRepresentation(UIImage(named: "Dubnyk.jpg")!, 1.0) as NSData?
            
            newGoalie.goalieHeadShot = goalieImage
            
            //Store Birthdate
            let dateString           = "1986-05-04"
            let dateFormatter        = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            newGoalie.dob          = date as NSDate?
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("ImportTestData|importGoalies: Fetch error: \(error) description: \(error.userInfo)")
        }
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GoalieInformation", in: managedContext)
            let newGoalie = GoalieInformation(entity: entity!, insertInto: managedContext)
            
            newGoalie.firstName    = "Braden"
            newGoalie.lastName     = "Holtby"
            newGoalie.number       = "70"
            newGoalie.city         = "Washington"
            newGoalie.teamName     = "Capitals"
            newGoalie.leagueName   = "NHL"
            newGoalie.divisionName = "Metropolitan"
            newGoalie.level        = "Professional"
            newGoalie.height       = "6'2\""
            newGoalie.weight       = "217 lb"
            
            //HeadShot
            let goalieImage = UIImageJPEGRepresentation(UIImage(named: "Holtby.jpg")!, 1.0) as NSData?
            
            newGoalie.goalieHeadShot = goalieImage
            
            //Store Birthdate
            let dateString           = "1989-09-16"
            let dateFormatter        = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            newGoalie.dob          = date as NSDate?
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("ImportTestData|importGoalies: Fetch error: \(error) description: \(error.userInfo)")
        }
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GoalieInformation", in: managedContext)
            let newGoalie = GoalieInformation(entity: entity!, insertInto: managedContext)
            
            newGoalie.firstName    = "Cam"
            newGoalie.lastName     = "Talbot"
            newGoalie.number       = "33"
            newGoalie.city         = "Edmonton"
            newGoalie.teamName     = "Oilers"
            newGoalie.leagueName   = "NHL"
            newGoalie.divisionName = "Pacific"
            newGoalie.level        = "Professional"
            newGoalie.height       = "6'3\""
            newGoalie.weight       = "193 lb"
            
            //HeadShot
            let goalieImage = UIImageJPEGRepresentation(UIImage(named: "Holtby.jpg")!, 1.0) as NSData?
            
            newGoalie.goalieHeadShot = goalieImage
            
            //Store Birthdate
            let dateString           = "1987-07-05"
            let dateFormatter        = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            newGoalie.dob          = date as NSDate?
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("ImportTestData|importGoalies: Fetch error: \(error) description: \(error.userInfo)")
        }
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GoalieInformation", in: managedContext)
            let newGoalie = GoalieInformation(entity: entity!, insertInto: managedContext)
            
            newGoalie.firstName    = "Tuukka"
            newGoalie.lastName     = "Rask"
            newGoalie.number       = "40"
            newGoalie.city         = "Boston"
            newGoalie.teamName     = "Bruins"
            newGoalie.leagueName   = "NHL"
            newGoalie.divisionName = "Atlantic"
            newGoalie.level        = "Professional"
            newGoalie.height       = "6'3\""
            newGoalie.weight       = "176 lb"
            
            //HeadShot
            let goalieImage = UIImageJPEGRepresentation(UIImage(named: "Rask.jpg")!, 1.0) as NSData?
            
            newGoalie.goalieHeadShot = goalieImage
            
            //Store Birthdate
            let dateString           = "1987-03-10"
            let dateFormatter        = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            newGoalie.dob          = date as NSDate?
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("ImportTestData|importGoalies: Fetch error: \(error) description: \(error.userInfo)")
        }
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GoalieInformation", in: managedContext)
            let newGoalie = GoalieInformation(entity: entity!, insertInto: managedContext)
            
            newGoalie.firstName    = "Martin"
            newGoalie.lastName     = "Jones"
            newGoalie.number       = "31"
            newGoalie.city         = "San Jose"
            newGoalie.teamName     = "Sharks"
            newGoalie.leagueName   = "NHL"
            newGoalie.divisionName = "Pacific"
            newGoalie.level        = "Professional"
            newGoalie.height       = "6'4\""
            newGoalie.weight       = "190 lb"
            
            //HeadShot
            let goalieImage = UIImageJPEGRepresentation(UIImage(named: "Jones.jpg")!, 1.0) as NSData?
            
            newGoalie.goalieHeadShot = goalieImage
            
            //Store Birthdate
            let dateString           = "1990-01-10"
            let dateFormatter        = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            newGoalie.dob          = date as NSDate?
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("ImportTestData|importGoalies: Fetch error: \(error) description: \(error.userInfo)")
        }
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GoalieInformation", in: managedContext)
            let newGoalie = GoalieInformation(entity: entity!, insertInto: managedContext)
            
            newGoalie.firstName    = "Carey"
            newGoalie.lastName     = "Price"
            newGoalie.number       = "31"
            newGoalie.city         = "Montréal"
            newGoalie.teamName     = "Canadiens"
            newGoalie.leagueName   = "NHL"
            newGoalie.divisionName = "Atlantic"
            newGoalie.level        = "Professional"
            newGoalie.height       = "6'3\""
            newGoalie.weight       = "226 lb"
            
            //HeadShot
            let goalieImage = UIImageJPEGRepresentation(UIImage(named: "Price.jpg")!, 1.0) as NSData?
            
            newGoalie.goalieHeadShot = goalieImage
            
            //Store Birthdate
            let dateString           = "1987-08-16"
            let dateFormatter        = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            newGoalie.dob          = date as NSDate?
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("ImportTestData|importGoalies: Fetch error: \(error) description: \(error.userInfo)")
        }
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GoalieInformation", in: managedContext)
            let newGoalie = GoalieInformation(entity: entity!, insertInto: managedContext)
            
            newGoalie.firstName    = "Henrik"
            newGoalie.lastName     = "Lundqvist"
            newGoalie.number       = "35"
            newGoalie.city         = "New York"
            newGoalie.teamName     = "Rangers"
            newGoalie.leagueName   = "NHL"
            newGoalie.divisionName = "Metropolitan"
            newGoalie.level        = "Professional"
            newGoalie.height       = "6'1\""
            newGoalie.weight       = "188 lb"
            
            //HeadShot
            let goalieImage = UIImageJPEGRepresentation(UIImage(named: "Lundqvist.jpg")!, 1.0) as NSData?
            
            newGoalie.goalieHeadShot = goalieImage
            
            //Store Birthdate
            let dateString           = "1982-03-02"
            let dateFormatter        = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            newGoalie.dob          = date as NSDate?
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("ImportTestData|importGoalies: Fetch error: \(error) description: \(error.userInfo)")
        }
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GoalieInformation", in: managedContext)
            let newGoalie = GoalieInformation(entity: entity!, insertInto: managedContext)
            
            newGoalie.firstName    = "Corey"
            newGoalie.lastName     = "Crawford"
            newGoalie.number       = "50"
            newGoalie.city         = "Chicago"
            newGoalie.teamName     = "Blackhawks"
            newGoalie.leagueName   = "NHL"
            newGoalie.divisionName = "Metropolitan"
            newGoalie.level        = "Professional"
            newGoalie.height       = "6'2\""
            newGoalie.weight       = "216 lb"
            
            //HeadShot
            let goalieImage = UIImageJPEGRepresentation(UIImage(named: "Crawford.jpg")!, 1.0) as NSData?
            
            newGoalie.goalieHeadShot = goalieImage
            
            //Store Birthdate
            let dateString           = "1984-12-31"
            let dateFormatter        = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            newGoalie.dob          = date as NSDate?
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("ImportTestData|importGoalies: Fetch error: \(error) description: \(error.userInfo)")
        }
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GoalieInformation", in: managedContext)
            let newGoalie = GoalieInformation(entity: entity!, insertInto: managedContext)
            
            newGoalie.firstName    = "Peter"
            newGoalie.lastName     = "Budaj"
            newGoalie.number       = "31"
            newGoalie.city         = "Tampa Bay"
            newGoalie.teamName     = "Lightning"
            newGoalie.leagueName   = "NHL"
            newGoalie.divisionName = "Atlantic"
            newGoalie.level        = "Professional"
            newGoalie.height       = "6'1\""
            newGoalie.weight       = "196 lb"
            
            //HeadShot
            let goalieImage = UIImageJPEGRepresentation(UIImage(named: "Budaj.jpg")!, 1.0) as NSData?
            
            newGoalie.goalieHeadShot = goalieImage
            
            //Store Birthdate
            let dateString           = "1982-09-18"
            let dateFormatter        = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            newGoalie.dob          = date as NSDate?
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("ImportTestData|importGoalies: Fetch error: \(error) description: \(error.userInfo)")
        }
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GameInformation", in: managedContext)
            let newGame = GameInformation(entity: entity!, insertInto: managedContext)
            
            
            //Store Birthdate
            let dateString           = "2017-03-13"
            let dateFormatter        = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            newGame.gameDateTime       = date as NSDate?
            newGame.oppositionTeamName = "Rangers"
            newGame.oppositionCity     = "New York"
            newGame.arenaCity          = "New York"
            newGame.arenaName          = "Madison Square Garden"
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("ImportTestData|importGoalies: Fetch error: \(error) description: \(error.userInfo)")
        }
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GameInformation", in: managedContext)
            let newGame = GameInformation(entity: entity!, insertInto: managedContext)
            
            
            //Store Birthdate
            let dateString           = "2017-03-03"
            let dateFormatter        = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            newGame.gameDateTime       = date as NSDate?
            newGame.oppositionTeamName = "Penguins"
            newGame.oppositionCity     = "Pittsburgh"
            newGame.arenaCity          = "Pittsburgh"
            newGame.arenaName          = "PPG Paints Arena"
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("ImportTestData|importGoalies: Fetch error: \(error) description: \(error.userInfo)")
        }
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GameInformation", in: managedContext)
            let newGame = GameInformation(entity: entity!, insertInto: managedContext)
            
            
            //Store Birthdate
            let dateString           = "2017-02-23"
            let dateFormatter        = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            newGame.gameDateTime       = date as NSDate?
            newGame.oppositionTeamName = "Bruins"
            newGame.oppositionCity     = "Boston"
            newGame.arenaCity          = "Tampa Bay"
            newGame.arenaName          = "Amalie Arena"
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("ImportTestData|importGoalies: Fetch error: \(error) description: \(error.userInfo)")
        }
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GameInformation", in: managedContext)
            let newGame = GameInformation(entity: entity!, insertInto: managedContext)
            
            
            //Store Birthdate
            let dateString           = "2017-03-16"
            let dateFormatter        = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            
            newGame.gameDateTime       = date as NSDate?
            newGame.oppositionTeamName = "Panthers"
            newGame.oppositionCity     = "Florida"
            newGame.arenaCity          = "Columbus"
            newGame.arenaName          = "Nationwide Arena"
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("ImportTestData|importGoalies: Fetch error: \(error) description: \(error.userInfo)")
        }
    }
} //class ImportTestData
