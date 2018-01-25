//
//  Locations.swift
//  MapTest1
//
//  Created by Arlind Aliu on 12/23/17.
//  Copyright © 2017 Arlind Aliu. All rights reserved.
//

import UIKit
import GoogleMaps

//42.664878, 21.158634 monroe
//42.664760, 21.157904 Chebar
//42.654239, 21.157108 Incorso
//42.654825, 21.156660 staybar
//42.654955, 21.156883 mellow

class Locations: NSObject {

    var locationArray = [LocationModel]()
    
    
    override init() {
    
        let location1 = LocationModel(emri: "Stay", tipi: "Kafe", distanca: "3113", latitude: 42.654825, longitude: 21.156660, perFemna: true, perMeshkuj: true, perInvalid: false, rating: "4.2", pershkrimi: "posht nalt majtas", camera: GMSCameraPosition.camera(withLatitude: 42.654825, longitude: 21.156660, zoom: 15) )
    
        locationArray.append(location1)
        
        
        let location2 = LocationModel(emri: "Mellow", tipi: "Kafe", distanca: "2224", latitude: 42.654955, longitude: 21.156883, perFemna: true, perMeshkuj: true, perInvalid: true, rating: "22", pershkrimi: "asdasdasdq232323232", camera: GMSCameraPosition.camera(withLatitude: 42.654955, longitude: 21.156883, zoom: 15))
        locationArray.append(location2)
        
        let location3 = LocationModel(emri: "Incorso", tipi: "kafe", distanca: "3442", latitude: 42.654239, longitude: 21.157108, perFemna: true, perMeshkuj: true, perInvalid: false, rating: "2.2", pershkrimi: "asdasdasd", camera: GMSCameraPosition.camera(withLatitude: 42.654239, longitude: 21.157108, zoom: 15))
        locationArray.append(location3)
        
        let location4 = LocationModel(emri: "CheBar", tipi: "LoungeBar", distanca: "1231", latitude: 42.664760, longitude: 21.157904, perFemna: true, perMeshkuj: true, perInvalid: true, rating: "4.8", pershkrimi: "Te rruga muharrem fejza, te kafet e vogla tek qafa, rruges per te shkallet e dragodanit, prapa stadiumit prishtina", camera: GMSCameraPosition.camera(withLatitude: 42.664760, longitude: 21.157904, zoom: 15))
        locationArray.append(location4)
        
        let location5 = LocationModel(emri: "Monroe", tipi: "Lounge Bar", distanca: "2231", latitude: 42.664878, longitude: 21.158634, perFemna: true, perMeshkuj: true, perInvalid: true, rating: "4.8", pershkrimi: "Tek qafa, perball mamounia bar ", camera: GMSCameraPosition.camera(withLatitude: 42.664878, longitude: 21.158634, zoom: 15))
        locationArray.append(location5)
        
    }
    
    
    
    
}
