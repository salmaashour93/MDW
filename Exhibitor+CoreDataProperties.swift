//
//  Exhibitor+CoreDataProperties.swift
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

extension Exhibitor {

    @NSManaged var companyUrl: String?
    @NSManaged var compnyName: String?
    @NSManaged var image: NSDate?
    @NSManaged var exhibitorId: NSNumber?
    @NSManaged var contactInfo: NSSet?

}
