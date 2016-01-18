//
//  Alarm+CoreDataProperties.swift
//  reveiller
//
//  Created by cwood on 1/17/16.
//  Copyright © 2016 caw. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension RealAlarm {

    @NSManaged var snoozeStart: NSNumber?
    @NSManaged var snoozeDecay: NSNumber?
    @NSManaged var alarmName: String?
    @NSManaged var alarmType: String?
    @NSManaged var targetTime: String?

}
