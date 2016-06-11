//
//  ExhibtorsTableViewController.swift
//  MDW
//
//  Created by Mohammed on 6/9/16.
//  Copyright © 2016 ITI. All rights reserved.
//

import UIKit

class ExhibtorsTableViewController: UITableViewController, ExhibtorsViewDelegate {

    var conn : NetworkManager!
    var exhibitorsList : [Exhibitor]!
    
    var activityIndicator : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        
        conn = NetworkManager()
        conn.exhibitorsDelegate = self
        
        exhibitorsList = Array<Exhibitor>()
        conn.getExhibitors((UIApplication.sharedApplication().delegate as! AppDelegate).currentUsername!)
        
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
        return exhibitorsList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("exhibitorCell", forIndexPath: indexPath)
        
        (cell.viewWithTag(10) as! UIImageView).imageFromUrl(exhibitorsList[indexPath.row].image!)
        (cell.viewWithTag(11) as! UILabel).text = exhibitorsList[indexPath.row].firstName!
        
        return cell
    }
    
    func ubdateExhibitors(exhibtors: [Exhibitor]) {
        self.exhibitorsList = exhibtors
        self.tableView.reloadData()
        activityIndicator.removeFromSuperview()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
