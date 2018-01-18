//
//  RatingViewCell.swift
//  MapTest1
//
//  Created by Arlind Aliu on 12/23/17.
//  Copyright © 2017 Arlind Aliu. All rights reserved.
//

import UIKit

class RatingViewCell: UITableViewCell {

    
    @IBOutlet weak var issueLbl: UILabel!
    @IBOutlet weak var overallRating: UILabel!
    @IBOutlet weak var starRating: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
