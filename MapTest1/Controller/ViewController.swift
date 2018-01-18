//
//  ViewController.swift
//  MapTest1
//
//  Created by Arlind Aliu on 12/23/17.
//  Copyright © 2017 Arlind Aliu. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlacePicker
import Alamofire
import SwiftyJSON

//https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins="\(UserLocation.sharedInstance.latitude,UserLocation.sharedInstance.longitude)"&destinations=42.654825%2C-21.156660%7C42.654955%2C21.156883%7C42.654239%2C21.157108%7C42.664760%2C-21.157904%7C42.664878%2C21.158634=AIzaSyD9OCUClqFN1Y9Qw_9JKyIr2E508oau-hw

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: GMSMapView! 
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    var placePicker: GMSPlacePicker!
    var locationManager = CLLocationManager()
    var currentPlace : CLLocation?
    var zoomLevel : Float = 15;
    var obj = Locations()
    var i = 0
    var didTouched: Bool = false
    let url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=\(UserLocation.sharedInstance.latitude,UserLocation.sharedInstance.longitude)&destinations=42.654825%2C-21.156660%7C42.654955%2C21.156883%7C42.654239%2C21.157108%7C42.664760%2C-21.157904%7C42.664878%2C21.158634=AIzaSyD9OCUClqFN1Y9Qw_9JKyIr2E508oau-hw"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        for x in i...(obj.locationArray.count - 1){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(obj.locationArray[x].latitude, obj.locationArray[x].longitude)
        marker.title = "\(obj.locationArray[x].emri)"
        marker.snippet = "\(obj.locationArray[x].tipi)"
        marker.map = mapView
        }
        
    }
    
    func getData(params: [String:Any]){
        Alamofire.request(url, method: .get, parameters: params).responseData { (data) in
            if data.result.isSuccess{
                let json = JSON(data.result.value!)
                
                print(json)
            }
        }
//        Alamofire.request(url).responseData {(data) in
//            if data.result.isSuccess{
//
//
//
//            }
//        }
        
    }
    
    
    func locationManager(manager: CLLocationManager,
                         didFailWithError error: NSError){
        
        print("An error occurred while tracking location changes : \(error.description)")
    }
   
    func statusAuthorize(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentPlace = locationManager.location
            UserLocation.sharedInstance.latitude = currentPlace?.coordinate.latitude
            UserLocation.sharedInstance.longitude = currentPlace?.coordinate.longitude
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse{
//            mapView.camera = GMSCameraPosition.camera(withLatitude: UserLocation.sharedInstance.latitude, longitude: UserLocation.sharedInstance.longitude, zoom: zoomLevel)
//        }
//    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        statusAuthorize()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celliJon") as! LocationCell
         cell.mbusheListen(locations: obj.locationArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsVC", sender: obj.locationArray[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsVC"{
            let detail = segue.destination as! DetailLocationVController
            detail.obj = sender as? LocationModel
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return obj.locationArray.count
    }


//func placePickerView(){
//    let center = CLLocationCoordinate2DMake(obj.locationArray[0].latitude, obj.locationArray[0].longitude)
//    let config = GMSPlacePickerConfig(viewport: nil)
//    self.placePicker = GMSPlacePicker(config: config)
////    present(placePicker, animated: true, completion: nil)
//    // 2
//    placePicker.pickPlace { (place: GMSPlace?, error: Error?) -> Void in
//
//        if let error = error {
//            print("Error occurred: \(error.localizedDescription)")
//            return
//        }
//        // 3
//        if let place = place {
//            let coordinates = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude)
//            let marker = GMSMarker(position: coordinates)
//            marker.title = place.name
//            marker.map = self.mapView
//            self.mapView.animate(toLocation: coordinates)
//        } else {
//            print("No place was selected")
//        }
//    }
//    }
    
    @IBAction func mapTouched(_ sender: UITapGestureRecognizer) {
        if sender.state == .began {
            
        if didTouched == false {
            
            self.viewHeight.constant = self.view.bounds.height
            
            UIView.animate(withDuration: 0.7, animations: {
                self.view.layoutIfNeeded()
            })
            didTouched = true
//        } else {
//            self.viewHeight.constant = 150
//
//            UIView.animate(withDuration: 0.7, animations: {
//                self.view.layoutIfNeeded()
//
//            })
//            didTouched = false
//            }
        
        }
        
        }}}
    

extension ViewController: CLLocationManagerDelegate , GMSMapViewDelegate{
         func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.first!
        print("Locations : \(location)")

        if location.horizontalAccuracy > 0 {
            //locationManager.stopUpdatingLocation()
            let latitude = String(location.coordinate.latitude)
            let longitute = String(location.coordinate.longitude)
       }

        let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude), zoom: zoomLevel)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }

    }

}




