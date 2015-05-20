//
//  DetailViewController.swift
//  barakah
//
//  Created by Naufal on 5/19/15.
//  Copyright (c) 2015 snapsell. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {
    
    var currentObject: PFObject?
    var inputField: UITextField?
    
//    self.navigationController?.pushViewController("MainViewTable", animated: true)
    @IBOutlet weak var getTitle: UILabel!
    
    @IBOutlet weak var getImage: PFImageView!
    
    @IBOutlet weak var getPrice: UILabel!
    
    @IBOutlet weak var getPhone: UILabel!
    
    @IBOutlet weak var getDate: UILabel!
    
    @IBOutlet weak var getDescription: UITextView!
    
    
    @IBAction func deleteAd(sender: AnyObject) {
        
        var alert = UIAlertController(title: "Enter the password", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            // Now do whatever you want with inputTextField (remember to unwrap the optional)
            if let object = self.currentObject {
                let password = object["password"] as? String
                
                if (self.inputField!.text == password) {
                    // Do the parse delete
                    object.deleteInBackground()
                    self.navigationController!.popViewControllerAnimated(true)
                   
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
       
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Enter text:"
            textField.secureTextEntry = true
            self.inputField = textField
            
            
        })
        self.presentViewController(alert, animated: true, completion: nil)
       println(inputField)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Unwrap the current object object
        if let object = currentObject {
            
            // Get title object
            getTitle.text = object["title"] as? String
            
            // Get Description
            getDescription.text = object["desc"] as? String
            
            // Get Price Object
            if let priceTitle = object["price"] as? Int {
                getPrice.text = String(priceTitle)
            }
            
            // Get Phone Number
            if let phoneNumber = object["phone"] as? Int {
                getPhone.text = String(phoneNumber)
            }
            
            // Get Date Object
            if let dateUpdated = object.updatedAt as NSDate? {
                var dateFormat = NSDateFormatter()
                dateFormat.dateFormat = "EEE, MMM d, h:mm a"
                getDate.text = NSString(format: "%@", dateFormat.stringFromDate(dateUpdated)) as String
            }
            
            // Get Image object
            var initialThumbnail = UIImage(named: "AppIcon")
            getImage.image = initialThumbnail
            if let thumbnail = object["image"] as? PFFile {
                getImage.file = thumbnail
                getImage.loadInBackground()
            }
            
        }

        // Do any additional setup after loading the view.
    }
    
//    func queryPhoneAndDesc() {
//        
//        var query = PFQuery(className: "product")
//        query.whereKey("title", equalTo: getTitle.text!)
//        query.getFirstObjectInBackgroundWithBlock {
//            (object: PFObject?, error: NSError?) -> Void in
//            if error != nil || object == nil {
//                
//            } else {
//                // The find succeeded.
//                self.getDescription.text = object!["desc"]!.description
//                
//                if let phoneNumber = object?["phone"] as? Int {
//                    self.getPhone.text = String(phoneNumber)
//                    
//                }
//            }
//        }
//
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
