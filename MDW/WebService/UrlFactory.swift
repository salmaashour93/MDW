//
//  UrlFactory.swift
//  MDW
//
//  Created by Mohammed on 6/7/16.
//  Copyright © 2016 Mohammed. All rights reserved.
//

import Foundation

class UrlFactory {

    let BASEURL = "http://www.mobiledeveloperweekend.net/service/"
    
    func getLoginUrl(username : String, password : String) -> String {
        return BASEURL + "login?userName=" + username + "&password=" + password
    }
    
    func getSessionsUrl(username : String) -> String {
        return BASEURL + "getSessions?userName=" + username
    }
    
    func getSpeakersUrl(username : String) -> String {
        return BASEURL + "getSpeakers?userName=" + username
    }
    
    func getProfileUrl(username : String) -> String {
        return BASEURL + "getAttendeeProfile?userName=" + username
    }
    
    func getProfileImageUrl(username : String) -> String {
        return BASEURL + "profileImage?userName=" + username
    }
    
    func getAttendAttendeeUrl(code : String) -> String {
        return BASEURL + "attendAttendee?code=" + code
    }
    
    func getAttendeeAgendaUrl(username : String) -> String {
        return BASEURL + "getAttendeeAgenda?userName=" + username
    }
    
    func getRegisterSessionUrl(username : String, sessionId : String, status : Int) -> String {
        return BASEURL + "registerSession?userName=" + username + "&sessionId=" + sessionId + "&status=" + String(status)
    }
    
    func getExhibitorsUrl(username : String) -> String {
        return BASEURL + "getExhibitors?userName=" + username
    }
}