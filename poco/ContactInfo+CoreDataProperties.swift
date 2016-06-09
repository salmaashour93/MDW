//
//  ContactInfo+CoreDataProperties.swift
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

extension ContactInfo {

    @NSManaged var infoType: String?
    @NSManaged var number: NSDecimalNumber?
    @NSManaged var ownerId: NSNumber?
    @NSManaged var ownerType: String?
    @NSManaged var user: NSManagedObject?
    @NSManaged var speaker: NSManagedObject?
    @NSManaged var exhibitor: NSManagedObject?

}
