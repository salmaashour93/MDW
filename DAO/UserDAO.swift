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
    
    
    func save(managedObjectContext : NSManagedObjectContext ,user : DbUser) -> DbUser!{
        
        let managedUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: self.managedObjectContext!) as! DbUser

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
    
    func selectAll(managedObjectContext : NSManagedObjectContext) -> [DbUser]{
        let fetched = NSFetchRequest(entityName : "User")
        var res : [DbUser]!
        do{
            res = try managedObjectContext.executeFetchRequest(fetched) as! [DbUser]
        }catch let error {
            
            print(error)
        }
        return res
    }
    
    func selectById(managedObjectContext : NSManagedObjectContext,Id _id :Int64) ->DbUser{
        
        let users = selectBy(managedObjectContext, attribute: "userId", value: String(_id))
        var user :DbUser!
        
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
    
    func selectBy(managedObjectContext : NSManagedObjectContext,attribute : String , value :String) -> [DbUser]{
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        let sortDescriptor = NSSortDescriptor(key: attribute, ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Create a new predicate that filters out any object that
        
        let predicate = NSPredicate(format: attribute + " = %@",value)
        
        fetchRequest.predicate = predicate
        var res : [DbUser]!
        do{
            res = try managedObjectContext.executeFetchRequest(fetchRequest) as! [DbUser]
        } catch let error {
            print(error)
        }
        return res
    }
    
    
    func addContactInfo(managedObjectContext moc : NSManagedObjectContext , userId _id :Int64 ,  mangedContectinfo : DbContactInfo ){
        
        let user = selectById(moc, Id: _id)
        let contactInfo = NSMutableSet(set: user.contactInfo!)
        contactInfo.addObject(contactInfo)
        user.contactInfo = contactInfo
        
     }
    
    
}