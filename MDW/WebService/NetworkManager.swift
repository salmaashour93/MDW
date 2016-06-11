//
//  NetworkManager.swift
//  MDW
//
//  Created by Mohammed on 6/7/16.
//  Copyright © 2016 Mohammed. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    var loginviewController : LoginViewDelegate!
    var agenda : AgendaViewDelegate!
    var speakersDelegate : SpeakersViewDelegate!
    var exhibitorsDelegate : ExhibtorsViewDelegate!
    var profileDelegate : ProfileViewDelegate!
    
    let urls : UrlFactory = UrlFactory()
    
    func connectTo(url : String, parameters : [String : AnyObject]) {
        Alamofire.request(.POST, url, parameters: parameters).responseJSON { (response) in
            print(response)
        }
    }
    
    func validateUserData(username : String, password : String) {
        let url = urls.getLoginUrl(username, password: password)
        print(url)
        Alamofire.request(.GET, url).responseJSON { (response) in
            //print(response.data)
            let json = JSON(data: response.data!)
            print(json["status"].stringValue)
            if json["status"].stringValue == "view.success" {
                let user = User()
                user.id = json["result"]["id"].double
                user.firstName = json["result"]["firstName"].stringValue
                user.middleName = json["result"]["middleName"].stringValue
                user.lastName = json["result"]["lastName"].stringValue
                user.country = json["result"]["countryName"].stringValue
                user.city = json["result"]["cityName"].stringValue
                user.title = json["result"]["title"].stringValue
                user.phones = json["result"]["phones"].arrayObject as! [String]?
                user.mobile = json["result"]["mobiles"].arrayObject as! [String]?
                user.gender = json["result"]["gender"].boolValue
                user.code = json["result"]["code"].stringValue
                user.birthDate = json["result"]["birthDate"].stringValue
                user.image = json["result"]["imageURL"].stringValue
                (UIApplication.sharedApplication().delegate as! AppDelegate).currentUser = user
                (UIApplication.sharedApplication().delegate as! AppDelegate).currentUsername = username
                NSUserDefaults.standardUserDefaults().setValue(user.code, forKey: "code")
                self.loginviewController.recieveValidationResult(true)

            } else {
                self.loginviewController.recieveValidationResult(false)
            }
        }
    }
    
    func getUserProfile(username : String, password : String) {
        let url = urls.getLoginUrl(username, password: password)
        print(url)
        Alamofire.request(.GET, url).responseJSON { (response) in
            //print(response.data)
            let json = JSON(data: response.data!)
            print(json["status"].stringValue)
            if json["status"].stringValue == "view.success" {
                let user = User()
                user.id = json["result"]["id"].double
                user.firstName = json["result"]["firstName"].stringValue
                user.middleName = json["result"]["middleName"].stringValue
                user.lastName = json["result"]["lastName"].stringValue
                user.country = json["result"]["countryName"].stringValue
                user.city = json["result"]["cityName"].stringValue
                user.title = json["result"]["title"].stringValue
                user.phones = json["result"]["phones"].arrayObject as! [String]?
                user.mobile = json["result"]["mobiles"].arrayObject as! [String]?
                user.gender = json["result"]["gender"].boolValue
                user.code = json["result"]["code"].stringValue
                user.birthDate = json["result"]["birthDate"].stringValue
                user.image = json["result"]["imageURL"].stringValue
                self.profileDelegate.receiveUserProfile(user)
            }
        }
    }

    func getSessions(username : String) {
        let url = urls.getSessionsUrl(username)
        Alamofire.request(.GET, url).responseJSON { (response) in
            let json = JSON(data: response.data!)
            var allAgendas : [Agenda] = Array<Agenda>()
            
            for agendaObj in json["result"]["agendas"] {
                let dayAgenda = Agenda()
                dayAgenda.date = agendaObj.1["date"].stringValue
                dayAgenda.sessions = Array<Session>()
                
                for sessionObj in agendaObj.1["sessions"] {
                    let session : Session = Session()
                    session.id = sessionObj.1["id"].doubleValue
                    session.name = sessionObj.1["name"].stringValue
                    session.location = sessionObj.1["location"].stringValue
                    session.description = sessionObj.1["description"].stringValue
                    session.status = sessionObj.1["status"].intValue
                    session.speakers = sessionObj.1["speakers"].arrayObject as? [Speaker]
                    session.sessionType = sessionObj.1["sessionType"].stringValue
                    session.liked = sessionObj.1["liked"].boolValue
                    let start = NSDate(timeIntervalSince1970: sessionObj.1["startDate"].doubleValue)
                    let startCalendar = NSCalendar.currentCalendar()
                    let startComp = startCalendar.components([.Hour, .Minute], fromDate: start)
                    session.startTime = String(startComp.hour) + " : " + String(startComp.minute)
                    let end = NSDate(timeIntervalSince1970: sessionObj.1["endDate"].doubleValue)
                    let endCalendar = NSCalendar.currentCalendar()
                    let endComp = endCalendar.components([.Hour, .Minute], fromDate: end)
                    session.endTime = String(endComp.hour) + " : " + String(endComp.minute)
                    
                    dayAgenda.sessions?.append(session)
                }
                allAgendas.append(dayAgenda)
            }
            //send data to UI thread
            self.agenda.updateAgendas(allAgendas)
        }
    }
    
    func getSpeakers(username : String) {
        
        let url = urls.getSpeakersUrl(username)
        Alamofire.request(.GET, url).responseJSON { (response) in
            let json = JSON(data: response.data!)
            var allSpeakers : [Speaker] = Array<Speaker>()
            
            for speakerObj in json["result"] {
                let speaker : Speaker = Speaker()
                speaker.id = speakerObj.1["id"].doubleValue
                speaker.firstName = speakerObj.1["firstName"].stringValue
                speaker.middleName = speakerObj.1["middleName"].stringValue
                speaker.lastName = speakerObj.1["lastName"].stringValue
                speaker.companyName = speakerObj.1["companyName"].stringValue
                speaker.title = speakerObj.1["title"].stringValue
                speaker.phones = speakerObj.1["phones"].arrayObject as! [String]?
                speaker.mobiles = speakerObj.1["mobiles"].arrayObject as! [String]?
                speaker.biography = speakerObj.1["biography"].stringValue
                speaker.gender = speakerObj.1["gender"].boolValue
                speaker.image = speakerObj.1["imageURL"].stringValue
                allSpeakers.append(speaker)
            }
            
            //send data to UI thread
            self.speakersDelegate.updateSpeakers(allSpeakers)
        }
    }
    
    func getExhibitors(username : String) {
        let url = urls.getExhibitorsUrl(username)
        Alamofire.request(.GET, url).responseJSON { (response) in
            let json = JSON(data: response.data!)
            var allExhibitors : [Exhibitor] = Array<Exhibitor>()
            
            for exhibitorObj in json["result"] {
                let exhibitor : Exhibitor = Exhibitor()
                exhibitor.firstName = exhibitorObj.1["contactName"].stringValue
                exhibitor.image = exhibitorObj.1["imageURL"].stringValue
                allExhibitors.append(exhibitor)
            }
            
            //send data to UI thread
            self.exhibitorsDelegate.ubdateExhibitors(allExhibitors)
        }
    }
}