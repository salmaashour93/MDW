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

extension DbContactInfo {

    @NSManaged var infoType: String?
    @NSManaged var number: NSDecimalNumber?
    @NSManaged var ownerId: NSNumber?
    @NSManaged var ownerType: String?
    @NSManaged var exhibitor: DbExhibitor?
    @NSManaged var speaker: DbSpeaker?
    @NSManaged var user: DbUser?

}
