//
//  LocationCell.swift
//  MapTest1
//
//  Created by Arlind Aliu on 12/23/17.
//  Copyright © 2017 Arlind Aliu. All rights reserved.
//

import UIKit
import CoreLocation

class LocationCell: UITableViewCell {

    @IBOutlet weak var emriLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var tipiLbl: UILabel!
    @IBOutlet weak var ratingStars: CosmosView!
    
    @IBOutlet weak var bottomBorder: GradientView!
    @IBOutlet weak var fotoELokalit: UIImageView!
    @IBOutlet weak var foto1: UIImageView!
    @IBOutlet weak var foto2: UIImageView!
    @IBOutlet weak var foto3: UIImageView!
    
    var gradientLayer: CAGradientLayer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 10.0
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        createGradientLayer()
    }
    
//    func createGradientLayer() {
//        gradientLayer = CAGradientLayer()
//
//        gradientLayer.frame.size.width = self.bottomBorder.frame.size.width
//
//        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
//
//        self.bottomBorder.layer.addSublayer(gradientLayer)
//    }
    
    func mbusheListen(locations: LocationModel){
        emriLbl.text = locations.emri
        
        ratingLbl.text = locations.rating
        tipiLbl.text = locations.tipi
        fotoELokalit.image = UIImage(named: locations.foto)
        ratingStars.rating = Double(locations.rating) ?? 0
        self.fotoELokalit.layer.masksToBounds = true
        if locations.perFemna == true{
            foto2.image = UIImage(named: "perFemna")
            
        } else {
            foto2.image = nil
            foto2.backgroundColor = UIColor.white
            foto2.layer.cornerRadius = 0
            foto2.layer.shadowColor = nil
            
        }
        if locations.perMeshkuj == true{
            foto1.image = UIImage(named: "perMeshkuj")
            
        } else {
            foto1.image = nil
            foto1.backgroundColor = UIColor.white
            foto1.layer.cornerRadius = 0
            foto1.layer.shadowColor = nil
        }
        if locations.perInvalid == true{
            foto3.image = UIImage(named: "perInvalid")
            
        } else {
            foto3.image = nil
            foto3.backgroundColor = UIColor.white
            foto3.layer.cornerRadius = 0
            foto3.layer.shadowColor = nil
        }
    }
    func updateDistancen(distance: CLLocationDistance){
        let formatDistance = String(format:"%.02f", distance/1000)
        distanceLbl.text = formatDistance + "km"
    }
}
