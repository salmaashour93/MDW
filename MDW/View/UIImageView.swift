//
//  UIImageView.swift
//  MDW
//
//  Created by Mohammed on 6/9/16.
//  Copyright © 2016 ITI. All rights reserved.
//

import Foundation

extension UIImageView {
    public func imageFromUrl(urlString : String){
        if let url = NSURL(string : urlString)  {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response : NSURLResponse?, data : NSData?, error : NSError?) in
                self.image = UIImage(data: data!)
            })
        }
    }
}