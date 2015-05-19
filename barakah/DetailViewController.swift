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
    
//    self.navigationController?.pushViewController("MainViewTable", animated: true)
    @IBOutlet weak var getTitle: UILabel!
    
    @IBOutlet weak var getImage: PFImageView!
    
    @IBOutlet weak var getPrice: UILabel!
    
    
    @IBOutlet weak var getPhone: UILabel!
    
    @IBOutlet weak var getDate: UILabel!
    
    @IBOutlet weak var getDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Unwrap the current object object
        if let object = currentObject {
            getTitle.text = object["title"] as? String
            getPrice.text = object["price"] as? String
            if let description = object["description"] as? String {
               getDescription.text = description
                println(getDescription.text)
            }
            
            queryDescription()
            
            
            if let priceTitle = object["price"] as? Int {
                getPrice.text = String(priceTitle)
               
            }

//            getDescription.text = object["description"] as! String
            var initialThumbnail = UIImage(named: "AppIcon")
            getImage.image = initialThumbnail
            if let thumbnail = object["image"] as? PFFile {
                getImage.file = thumbnail
                getImage.loadInBackground()
            }
        }

        // Do any additional setup after loading the view.
    }
    
    
    
    func queryDescription() {
        
        var query = PFQuery(className: "product")
        query.whereKey("title", equalTo: getTitle.text!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                
            } else {
                // The find succeeded.
                self.getDescription.text = object!["desc"]!.description
                
                if let phoneNumber = object?["phone"] as? Int {
                    self.getPhone.text = String(phoneNumber)
                    
                }
                
                if let dateUpdated = object?.updatedAt as NSDate? {
                    var dateFormat = NSDateFormatter()
                    dateFormat.dateFormat = "EEE, MMM d, h:mm a"
                    self.getDate.text = NSString(format: "%@", dateFormat.stringFromDate(dateUpdated)) as String
                }

//                self.getDate.text = object!["createdAt"]!.description
                println(self.getDescription.text)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
