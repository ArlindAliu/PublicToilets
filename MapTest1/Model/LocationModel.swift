//
//  LocationModel.swift
//  MapTest1
//
//  Created by Arlind Aliu on 12/23/17.
//  Copyright © 2017 Arlind Aliu. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationModel: NSObject {
    
    let emri: String
    let tipi: String
    var distanca: String
    let latitude: Double
    let longitude: Double
    let perFemna: Bool
    let perMeshkuj: Bool
    let perInvalid: Bool
    var rating: String
    let pershkrimi: String
    let camera: GMSCameraPosition
    var foto : String
    let urlPhoto : String = "https://scontent.fprx2-1.fna.fbcdn.net/v/t1.0-9/16729136_1392230747509127_6670818541267376519_n.jpg?oh=7ff91f5ebff5bc2c92697e2c88489544&oe=5AD9C724"
    
    init(emri: String, tipi: String, distanca: String, latitude: Double, longitude: Double, perFemna: Bool, perMeshkuj: Bool, perInvalid: Bool, rating: String, pershkrimi: String, camera: GMSCameraPosition, foto: String) {
        
        self.emri = emri
        self.tipi = tipi
        self.distanca = distanca
        self.latitude  = latitude
        self.longitude = longitude
        self.perFemna = perFemna
        self.perMeshkuj = perMeshkuj
        self.perInvalid = perInvalid
        self.rating = rating
        self.pershkrimi = pershkrimi
        self.camera = camera
        self.foto = foto
    
    }
    func updatePhoto () -> String{
        return  urlPhoto
    }

}
