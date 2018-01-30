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
    let distanca: String
    let latitude: Double
    let longitude: Double
    let perFemna: Bool
    let perMeshkuj: Bool
    let perInvalid: Bool
    let rating: String
    let pershkrimi: String
    let camera: GMSCameraPosition
    let foto : String
    
    
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
    

}
