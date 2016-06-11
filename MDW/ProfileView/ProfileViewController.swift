//
//  ProfileViewController.swift
//  MDW
//
//  Created by Ahmed Hamdy on 6/3/16.
//  Copyright © 2016 ITI. All rights reserved.
//

import UIKit
//import ZXingObjC
import QRCode
class ProfileViewController: UIViewController, ProfileViewDelegate {

    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var QRImage: UIImageView!
    
    var activityIndicator : UIActivityIndicatorView!

    var conn : NetworkManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conn = NetworkManager()
        conn.profileDelegate = self
        conn.getUserProfile(NSUserDefaults.standardUserDefaults().objectForKey("username") as! String, password: NSUserDefaults.standardUserDefaults().objectForKey("password") as! String)
        
        activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .Gray)
        activityIndicator.center = self.view.center;
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)

        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!);
    }
    
    func receiveUserProfile(user: User) {
        dispatch_async(dispatch_get_main_queue()){
            self.nameLabel.text = user.firstName! + " " + user.lastName!
            self.titleLabel.text = user.title
            self.companyLabel.text = user.company
            self.QRImage.image = self.getBarCodeImage(user.code!)
            self.imgProfile.imageFromUrl(user.image!)
        }
        activityIndicator.removeFromSuperview()
    }
    
    func getBarCodeImage(code : String) -> UIImage{
        
        var qrCode = QRCode(code)
        qrCode!.size = CGSize(width: 300, height: 300)
        return qrCode!.image!
//        let err : NSError?
//        let imagee : UIImage!
//        
//        var writer = ZXMultiFormatWriter.writer() as! ZXMultiFormatWriter;
//        //var writer = ZXMultiFormatWriter().writer() as! ZXMultiFormatWriter;
//        do{
//            let resultR : ZXBitMatrix = try writer.encode(code, format: kBarcodeFormatQRCode
//                , width: 30, height: 30)
//            let imageRef = ZXImage.init(matrix: resultR);
//            imagee = UIImage(CGImage: imageRef.cgimage)
//            self.QRImage.image = imagee ;
//            return imagee;
//        }
//        catch let err as NSError{
//            print(err.localizedDescription);
//            let imageRef = UIImage(named: "profile")
//            //imagee = UIImage(CGImage: imageRef)
//            return imageRef!;
//        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
