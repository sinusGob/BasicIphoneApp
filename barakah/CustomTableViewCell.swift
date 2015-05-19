//
//  CustomTableViewCell.swift
//  barakah
//
//  Created by Naufal on 5/18/15.
//  Copyright (c) 2015 snapsell. All rights reserved.
//
import UIKit
import Parse
import ParseUI

class CustomTableViewCell: PFTableViewCell {
    
    
//    @IBOutlet weak var customImage: PFImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var customImage: PFImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var date: UILabel!
}


