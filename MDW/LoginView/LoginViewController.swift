//
//  LoginViewController.swift
//  MDW
//
//  Created by Mohammed on 6/3/16.
//  Copyright © 2016 Mohammed. All rights reserved.
//

import UIKit

class LoginViewController: UITableViewController, LoginViewDelegate {

    var conn : NetworkManager!
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    
    var activityIndicator : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        
        conn = NetworkManager()
        conn.loginviewController = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    @IBAction func doLogin(sender: AnyObject) {
        if (txtPassword.text == "" || txtUsername.text == "") {
            lblResult.text = "Missed username or password"
        } else {
            conn.validateUserData(txtUsername.text!, password: txtPassword.text!)
            
            activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .Gray)
            activityIndicator.center = self.view.center;
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
        }
    }
    
    func recieveValidationResult(result: Bool) {
        if result {
            var centerContainer: MMDrawerController?
            let leftDrawer =  storyboard!.instantiateViewControllerWithIdentifier("LeftViewController") as! LeftViewController
            let center = storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! UITabBarController
            
            let leftSideNav = UINavigationController(rootViewController: leftDrawer)
            let centerNav = UINavigationController(rootViewController: center)
            
            leftDrawer.title="MDW"
            
            centerContainer = MMDrawerController(centerViewController: centerNav, leftDrawerViewController: leftSideNav)
            
            centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView;
            centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView;
            
            NSUserDefaults.standardUserDefaults().setValue(txtUsername.text, forKey: "username")
            NSUserDefaults.standardUserDefaults().setValue(txtPassword.text, forKey: "password")
            self.presentViewController(centerContainer!, animated: true, completion: nil)
        } else {
            lblResult.text = "Invalid username or password"
        }
        activityIndicator.removeFromSuperview()
    }
}
