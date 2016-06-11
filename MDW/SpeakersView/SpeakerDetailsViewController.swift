//
//  SpeakerDetailsViewController.swift
//  MDW
//
//  Created by Mohammed on 6/10/16.
//  Copyright © 2016 ITI. All rights reserved.
//

import UIKit

class SpeakerDetailsViewController: UIViewController {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var txtBiography: UITextView!

    var speaker : Speaker!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)

        lblName.text = speaker.firstName! + speaker.lastName!
        imgView.imageFromUrl(speaker.image!)
        txtBiography.text = speaker.biography
        lblTitle.text = speaker.title
        lblCompany.text = speaker.companyName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
