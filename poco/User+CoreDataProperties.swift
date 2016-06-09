//
//  User+CoreDataProperties.swift
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

extension User {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var middleName: String?
    @NSManaged var companyName: String?
    @NSManaged var email: String?
    @NSManaged var image: NSData?
    @NSManaged var password: String?
    @NSManaged var qrCode: String?
    @NSManaged var title: String?
    @NSManaged var contactInfo: NSSet?

}
