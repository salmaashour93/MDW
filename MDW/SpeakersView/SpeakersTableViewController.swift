//
//  SpeakersTableViewController.swift
//  MDW
//
//  Created by Mohammed on 6/9/16.
//  Copyright © 2016 ITI. All rights reserved.
//

import UIKit

class SpeakersTableViewController: UITableViewController, SpeakersViewDelegate {

    var conn : NetworkManager!
    var speakersList : [Speaker]!
    var activityIndicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        
        conn = NetworkManager()
        conn.speakersDelegate = self
        speakersList = Array<Speaker>()
        conn.getSpeakers((UIApplication.sharedApplication().delegate as! AppDelegate).currentUsername!)
        
        activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .Gray)
        activityIndicator.center = self.view.center;
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speakersList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("speakerCell", forIndexPath: indexPath)

        (cell.viewWithTag(10) as! UIImageView).imageFromUrl(speakersList[indexPath.row].image!)
        (cell.viewWithTag(11) as! UILabel).text = speakersList[indexPath.row].firstName! + " " + speakersList[indexPath.row].lastName!
        (cell.viewWithTag(12) as! UILabel).text = speakersList[indexPath.row].companyName!
        
        return cell
    }

    
    func updateSpeakers(speakers: [Speaker]) {
        self.speakersList = speakers
        self.tableView.reloadData()
        activityIndicator.removeFromSuperview()
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let selectedSpeaker = speakersList[(self.tableView.indexPathForSelectedRow?.row)!]
        (segue.destinationViewController as! SpeakerDetailsViewController).speaker = selectedSpeaker
        
        self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow!, animated: true)
    }
    

}
