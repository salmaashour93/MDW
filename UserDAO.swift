//
//  UserDAO.swift
//  MDW
//
//  Created by ZOBA on 6/9/16.
//  Copyright © 2016 ITI. All rights reserved.
//

import Foundation
import CoreData

class UserDAO  {

    var managedObjectContext : NSManagedObjectContext!
    
    init(managedObjectContext : NSManagedObjectContext){
        self.managedObjectContext = managedObjectContext
    }
    
    
    func save(managedObjectContext : NSManagedObjectContext ,unmanagedUser user : User) -> User!{
        
        let managedUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: self.managedObjectContext!) as! User

        managedUser.firstName = user.firstName
        managedUser.email = user.email
        managedUser.userId = user.userId
        managedUser.image = user.image
        managedUser.lastName = user.lastName
        managedUser.middleName = user.middleName
        managedUser.password = user.password
        managedUser.title = user.title
        managedUser.companyName = user.companyName
        managedUser.image = user.image
        managedUser.qrCode = user.qrCode
        
        
        if(user.contactInfo!.count > 0)
        {
            managedUser.contactInfo = user.contactInfo
        }
        do {
            try managedObjectContext.save()
            print("saved")
        }
        catch let error {
            print(error)
        }
        return user;
        
   }
    
}