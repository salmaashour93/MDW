//
//  LeftViewController.swift
//  MDW
//
//  Created by Ahmed Hamdy on 6/3/16.
//  Copyright © 2016 ITI. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    var menuItems:[String] = ["Agenda","My agenda","Speakers","Exihiptors","Profile", "Logout", ""];
    var menuPics:[String] = ["agenda.png","myagenda.png","speaker.png","exihiptors.png","profile.png", "logout.png", "logo1.png"];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuItems.count;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        
    {
        var mycell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! MyCustomViewCell
        
        mycell.textLabel?.text = menuItems[indexPath.row]
        
        mycell.imageView?.image = UIImage(named: menuPics[indexPath.row])
        
        
        return mycell;
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        switch(indexPath.row)
        {
            
        case 0:
            
            var centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            
            var centerNavController = UINavigationController(rootViewController: centerViewController)
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
            break;
            
        case 1:
            
            /*    var aboutViewController = self.storyboard?.instantiateViewControllerWithIdentifier(“AboutViewController”) as AboutViewController
            
            var aboutNavController = UINavigationController(rootViewController: aboutViewController)
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = aboutNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
            */
            break;
            
        default:
            
            print("\(menuItems[indexPath.row]) is selected");
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
