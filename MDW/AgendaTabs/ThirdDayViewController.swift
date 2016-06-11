//
//  ThirdDayViewController.swift
//  MDW
//
//  Created by Mohammed on 6/7/16.
//  Copyright © 2016 Mohammed. All rights reserved.
//

import UIKit

class ThirdDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AgendaViewDelegate {

    @IBOutlet weak var agendaTable: UITableView!
    var conn : NetworkManager!
    var sessions : [Session]!
    var refreshController = UIRefreshControl();
    
    var activityIndicator : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        conn = NetworkManager()
        conn.agenda = self
        
        sessions = Array<Session>()
        conn.getSessions((UIApplication.sharedApplication().delegate as! AppDelegate).currentUsername!)
        
        activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .Gray)
        activityIndicator.center = self.view.center;
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)

        self.refreshController.addTarget(self, action: "didRefreshList", forControlEvents: .ValueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didRefreshList() {
        conn.getSessions((UIApplication.sharedApplication().delegate as! AppDelegate).currentUsername!)
        self.refreshController.endRefreshing();
    }
    
    
    func renderHtml(let txt : String) -> NSAttributedString {
        let htmlFormat = txt //html format
        let attrStr = try! NSAttributedString(
            data: htmlFormat.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        return attrStr
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ThirdCell", forIndexPath: indexPath)
        
        (cell.viewWithTag(11) as! UILabel).attributedText = self.renderHtml(self.sessions[indexPath.row].name!);
        (cell.viewWithTag(12) as! UILabel).text = self.sessions[indexPath.row].location
        (cell.viewWithTag(13) as! UILabel).text = self.sessions[indexPath.row].startTime! + " - " + self.sessions[indexPath.row].endTime!
        switch(self.sessions[indexPath.row].sessionType!)
        {
        case "Session":
            (cell.viewWithTag(10) as! UIImageView).image = UIImage(named: "session")
            break;
        case "Break":
            (cell.viewWithTag(10) as! UIImageView).image = UIImage(named: "breakicon");
            break;
        case "Hackathon":
            (cell.viewWithTag(10) as! UIImageView).image = UIImage(named: "calender");
            break;
        case "Workshop":
            (cell.viewWithTag(10) as! UIImageView).image = UIImage(named: "workshop");
            break;
        default:
            break;
        }
        return cell
    }
    
    func updateAgendas(agendas: [Agenda]) {
        sessions = agendas[2].sessions
        agendaTable.reloadData()
        activityIndicator.removeFromSuperview()
    }
}
