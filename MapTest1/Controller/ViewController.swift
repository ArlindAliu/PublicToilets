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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , GMSMapViewDelegate {
    
    @IBOutlet weak var animateMap: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: GMSMapView! 
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    var placePicker: GMSPlacePicker!
    var locationManager = CLLocationManager()
    var currentPlace : CLLocation?
    var zoomLevel : Float = 15;
    var obj = Locations()
    var didTouched: Bool = false
    let url = URL(string : "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=\(UserLocation.sharedInstance.latitude,UserLocation.sharedInstance.longitude)&destinations=42.654825%2C-21.156660%7C42.654955%2C21.156883%7C42.654239%2C21.157108%7C42.664760%2C-21.157904%7C42.664878%2C21.158634=AIzaSyD9OCUClqFN1Y9Qw_9JKyIr2E508oau-hw")
    var distanca = CLLocationDistance()
    var location1: CLLocation?
    

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
        self.mapView.delegate = self
        
        func mapView(_mapView: GMSMapView, didTap: GMSMarker){
            print("AAAAAAAAAAAAAAAAAAAAA")
        }
        
        
        for index in 0...(obj.locationArray.count - 1){
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(obj.locationArray[index].latitude, obj.locationArray[index].longitude)
            marker.title = "\(obj.locationArray[index].emri)"
            marker.snippet = "\(obj.locationArray[index].tipi)"
            marker.isTappable = true
            marker.map = self.mapView

            
        let locationDistance = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
        let userCurrentLocation = CLLocation(latitude: 42.654825, longitude: 21.156660)
        distanca = userCurrentLocation.distance(from: locationDistance)
        let distancaNeKilometra = (distanca / 1000)
            
           let roundDistance = String(format:"%.02f", distancaNeKilometra)
            
            
            obj.locationArray[index].distanca = "\(roundDistance)km"
            
        }
        
        
    }
    func getData(params: [String:Any]){
        Alamofire.request(url!, method: .get, parameters: params).responseData { (data) in
            if data.result.isSuccess{
                let json = JSON(data.result.value!)
                
                print(json)
            }
        }

    }
    
     func mapView(_mapView: GMSMapView, didTap: GMSMarker)  {
        
        
        
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        statusAuthorize()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celliJon") as! LocationCell
         cell.mbusheListen(locations: obj.locationArray[indexPath.row])
        tableView.rowHeight = 120
        
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

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("Coordinate eshte e barabarte me  = \(coordinate.latitude)")
                    if didTouched == false {
 
                        self.viewHeight.constant = self.view.bounds.height
                        
                        UIView.animate(withDuration: 0.7, animations: {
                            self.view.layoutIfNeeded()
                        })
                        didTouched = true
                    } else {
                       
                        self.viewHeight.constant = 200
                        
                        UIView.animate(withDuration: 0.7, animations: {
                            self.view.layoutIfNeeded()
        
                        })
                        didTouched = false
        
        
                }
    }
    
    internal func mapView(_ mapView: GMSMapView, didTap marker : GMSMarker) -> Bool{
        
        
            

        print("LLLLLLLLLLLLLLAALALALLALALALALALAL")
        return true
    }
    

}
extension ViewController: CLLocationManagerDelegate {
         func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.first!
        print("Locations : \(location)")

        if location.horizontalAccuracy > 0 {
            //locationManager.stopUpdatingLocation()
            _ = String(location.coordinate.latitude)
            _ = String(location.coordinate.longitude)
       }

        let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude), zoom: zoomLevel)
        mapView.settings.myLocationButton = true
       
        mapView.isMyLocationEnabled = true
        mapView.settings.accessibilityNavigationStyle = .combined
//            if mapView.settings.accessibilityNavigationStyle == .combined {
//                let path = GMSPath()
//
//            }
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }

    }

}




