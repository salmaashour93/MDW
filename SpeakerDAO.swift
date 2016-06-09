//
//  SpeakerDao.swift
//  MDW
//
//  Created by ZOBA on 6/9/16.
//  Copyright © 2016 ITI. All rights reserved.
//

import Foundation
import CoreData

class SpeakerDAO {
 
    var mangedObjectContext : NSManagedObjectContext!
    
    init(mangedObjectContext : NSManagedObjectContext)
    {
        self.mangedObjectContext = mangedObjectContext
    }
    
    func save(managedObjectContext : NSManagedObjectContext , speaker : Speaker )-> Speaker  {
        
        let mangededSpeaker = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: self.mangedObjectContext) as! Speaker
        
        mangededSpeaker.compnyName = speaker.compnyName
        mangededSpeaker.biography = speaker.biography
        mangededSpeaker.firstName = speaker.firstName
        mangededSpeaker.image = speaker.image
        mangededSpeaker.lastName = speaker.lastName
        mangededSpeaker.middleName = speaker.middleName
        mangededSpeaker.speakerId =  speaker.speakerId
        mangededSpeaker.title = speaker.title

        
        if(speaker.contactInfo!.count > 0)
        {
            mangededSpeaker.contactInfo = speaker.contactInfo
        }
        do {
            try managedObjectContext.save()
            print("saved")
        }
        catch let error {
            print(error)
        }
        
        
        if(speaker.session!.count > 0)
        {
            mangededSpeaker.session = speaker.session
        }
        do {
            try managedObjectContext.save()
            print("saved")
        }
        catch let error {
            print(error)
        }
        
        
       return speaker
    }
    
    
    func addContectInfo(managedObjectContext moc : NSManagedObjectContext , userId _id :Int64 , managedContect : ContactInfo){
        
        let speaker = selectById(moc, Id: _id)
        let contactInfo = NSMutableSet(set: speaker.contactInfo!)
        contactInfo.addObject(contactInfo)
        speaker.contactInfo = contactInfo
        
    }
    
    func addSession(managedObjectContext moc : NSManagedObjectContext , userId _id :Int64 , managedContect : Session){
        
        let speaker = selectById(moc, Id: _id)
        let session = NSMutableSet(set: speaker.session!)
        session.addObject(session)
        speaker.session = session

    }
    
    func selectAll(managedObjectContext : NSManagedObjectContext) -> [Speaker]{
        let fetched = NSFetchRequest(entityName : "Speaker")
        var res : [Speaker]!
        do{
            res = try managedObjectContext.executeFetchRequest(fetched) as! [Speaker]
        }catch let error {
            
            print(error)
        }
        return res
    }
    
    func selectById(managedObjectContext : NSManagedObjectContext,Id _id :Int64) ->Speaker{
        
        let speakers = selectBy(managedObjectContext, attribute: "speakerId", value: String(_id))
        var speaker :Speaker!
        
        if speakers.count > 0 {
            speaker = speakers[0]
        }
        return speaker
    }
    
    
    func selectBy(managedObjectContext : NSManagedObjectContext,attribute : String , value :String) -> [Speaker]{
        
        let fetchRequest = NSFetchRequest(entityName: "Speaker")
        let sortDescriptor = NSSortDescriptor(key: attribute, ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Create a new predicate that filters out any object that
        
        let predicate = NSPredicate(format: attribute + " = %@",value)
        
        fetchRequest.predicate = predicate
        var res : [Speaker]!
        do{
            res = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Speaker]
        } catch let error {
            print(error)
        }
        return res
    }
    
}