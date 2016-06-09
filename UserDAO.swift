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
    
    func selectAll(managedObjectContext : NSManagedObjectContext) -> [User]{
        let fetched = NSFetchRequest(entityName : "User")
        var res : [User]!
        do{
            res = try managedObjectContext.executeFetchRequest(fetched) as! [User]
        }catch let error {
            
            print(error)
        }
        return res
    }
    
    func selectById(managedObjectContext : NSManagedObjectContext,Id _id :Int64) ->User{
        
        
        let users = selectBy(managedObjectContext, attribute: "userId", value: String(_id))
        var user :User!
        
        if users.count > 0 {
            user = users[0]
        }
        return user
    }
    
    func delete(managedObjectContext : NSManagedObjectContext,Id _id :Int64){
        let user = selectById(managedObjectContext, Id: _id)
        do{
            managedObjectContext.deleteObject(user)
            try managedObjectContext.save()
        }
        catch let error {
            print(error)
        }
    }
    
    func selectBy(managedObjectContext : NSManagedObjectContext,attribute : String , value :String) -> [User]{
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        let sortDescriptor = NSSortDescriptor(key: attribute, ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Create a new predicate that filters out any object that
        
        let predicate = NSPredicate(format: attribute + " = %@",value)
        
        fetchRequest.predicate = predicate
        var res : [User]!
        do{
            res = try managedObjectContext.executeFetchRequest(fetchRequest) as! [User]
        } catch let error {
            print(error)
        }
        return res
    }
    
    
}