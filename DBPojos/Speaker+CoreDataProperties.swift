//
//  Speaker+CoreDataProperties.swift
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

extension DbSpeaker {

    @NSManaged var biography: String?
    @NSManaged var compnyName: String?
    @NSManaged var firstName: String?
    @NSManaged var image: NSData?
    @NSManaged var lastName: String?
    @NSManaged var middleName: String?
    @NSManaged var title: String?
    @NSManaged var speakerId: NSNumber?
    @NSManaged var contactInfo: NSSet?
    @NSManaged var session: NSSet?

}
