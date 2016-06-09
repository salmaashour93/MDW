//
//  Session+CoreDataProperties.swift
//  MDW
//
//  Created by ZOBA on 6/9/16.
//  Copyright © 2016 ITI. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Session {

    @NSManaged var endDate: NSNumber?
    @NSManaged var liked: String?
    @NSManaged var location: String?
    @NSManaged var name: String?
    @NSManaged var sessionDescription: String?
    @NSManaged var sessionId: NSNumber?
    @NSManaged var startDate: NSNumber?
    @NSManaged var status: String?
    @NSManaged var type: String?
    @NSManaged var speaker: NSSet?

}
