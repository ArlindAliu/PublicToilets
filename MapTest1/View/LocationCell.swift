//
//  LocationCell.swift
//  MapTest1
//
//  Created by Arlind Aliu on 12/23/17.
//  Copyright © 2017 Arlind Aliu. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var emriLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var tipiLbl: UILabel!

    @IBOutlet weak var foto1: UIImageView!
    @IBOutlet weak var foto2: UIImageView!
    @IBOutlet weak var foto3: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func mbusheListen(locations: LocationModel){
        emriLbl.text = locations.emri
        distanceLbl.text = locations.distanca
        ratingLbl.text = locations.rating
        tipiLbl.text = locations.tipi
        
//        longLbl.text = "\(locations.longitude)"
//        latLbl.text = "\(locations.latitude)"
    }
}
