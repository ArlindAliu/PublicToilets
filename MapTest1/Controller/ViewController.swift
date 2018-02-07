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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , GMSMapViewDelegate , RatingDelegate{
    
    @IBOutlet weak var animateMap: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: GMSMapView! 
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var goButton: UIButton!
    
    var placePicker: GMSPlacePicker!
    var locationManager = CLLocationManager()
    var currentPlace : CLLocation?
    var zoomLevel : Float = 15;
    var obj = Locations()
    var didTouched: Bool = false
    let url = URL(string : "https://maps.googleapis.com/maps/api/directions/json?origin=42.654239,21.157108&destination=42.664760,21.157904&key=AIzaSyB5gTvTzQpq0-mkGS6LDceAnQKAU4FPPbY")
    var distanca = CLLocationDistance()
    var ratingString: String?
    var distanceArray = [CLLocationDistance()]
    let userCurrentLocation = CLLocation(latitude: (42.654239), longitude: (21.157108))

    
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
        
  
        for index in 0...(obj.locationArray.count - 1){
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(obj.locationArray[index].latitude, obj.locationArray[index].longitude)
            marker.title = "\(obj.locationArray[index].emri)"
            marker.snippet = "\(obj.locationArray[index].tipi)"
            marker.isTappable = true
            marker.map = self.mapView
            
            
        let locationDistance = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
        distanca = userCurrentLocation.distance(from: locationDistance)
        let distancaNeKilometra = (distanca / 1000)
        distanceArray.append(distancaNeKilometra)
         
           let roundDistance = String(format:"%.02f", distanceArray.sorted(by: <))
           obj.locationArray[index].distanca = "\(roundDistance)km"
            print(distanceArray.sorted(by: <))
        }
         goButton.frame = CGRect(x: 310, y: 160, width: 30, height: 30)
         self.view.addSubview(goButton)
         goButton.isHidden = true
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
       goButton.isHidden = false
        return true
 
    }
    
    func getData(){
        Alamofire.request(url!).responseData{ response in
            if let JSON = response.result.value{
                
                let mapResponse: [String : Any] = JSON as! [String : Any]
                
                let routesArray = (mapResponse["routes"] as? Array) ?? []
                
                let routes = (routesArray.first as? Dictionary<String, AnyObject>) ?? [:]
                
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                print("\(mapResponse) = MAP RESPONSE ")
                self.addPolyLine(encodedString: line)
                
            }
        }
    }
    
    @IBAction func showDirection(_ sender: Any) {
        getData()
    }
    func addPolyLine(encodedString: String) {
        
        let path = GMSMutablePath(fromEncodedPath: encodedString)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 5
        polyline.strokeColor = .blue
        polyline.map = mapView
        
    }
    func ratingValue(ratingTxt: String) {
        ratingString = ratingTxt
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
        cell.mbusheListen(locations: obj.locationArray[indexPath.row], rating : ratingString ?? "4.2")
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
                        goButton.frame = CGRect(x: 310, y: 540, width: 50, height: 50)
                        UIView.animate(withDuration: 0.7, animations: {
                            self.view.layoutIfNeeded()
                        })
                        didTouched = true
                    } else {
                       
                        self.viewHeight.constant = 200
                        goButton.frame = CGRect(x: 310, y: 160, width: 30, height: 30)
                        
                        UIView.animate(withDuration: 0.7, animations: {
                            self.view.layoutIfNeeded()
        
                        })
                        didTouched = false
        
        }
    }
    
}
extension ViewController: CLLocationManagerDelegate {
         func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.first!
            tableView.reloadData()
        print("Locations : \(location)")

        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
//            _ = String(location.coordinate.latitude)
//            _ = String(location.coordinate.longitude)
       }

        let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude), zoom: zoomLevel)
            
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.settings.accessibilityNavigationStyle = .combined

        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }

    }

}




