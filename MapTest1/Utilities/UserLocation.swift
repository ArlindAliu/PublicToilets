//
//  UserLocation.swift
//  MapTest1
//
//  Created by Arlind Aliu on 12/26/17.
//  Copyright © 2017 Arlind Aliu. All rights reserved.
//

import CoreLocation

class UserLocation {
    
    static var sharedInstance = UserLocation()
    
    private init (){
        
    } 
    
    var latitude: Double!
    var longitude: Double!
}
