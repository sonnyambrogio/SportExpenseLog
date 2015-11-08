//
//  Expense+CoreDataProperties.swift
//  SportExpenseLog
//
//  Created by Sonny Ambrogio on 2015-10-13.
//  Copyright © 2015 Viking Panda. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Expense {

    @NSManaged var date: NSDate?
    @NSManaged var equipmentCost: NSNumber?
    @NSManaged var foodCost: NSNumber?
    @NSManaged var gamesAttended: NSNumber?
    @NSManaged var hotelCost: NSNumber?
    @NSManaged var kmDriven: NSNumber?
    @NSManaged var titleValue: String?

}
