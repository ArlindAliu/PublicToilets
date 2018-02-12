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
import AlamofireImage


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , GMSMapViewDelegate , RatingDelegate{
    
    @IBOutlet weak var animateMap: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: GMSMapView! 
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var Xbutton: UIButton!
    @IBOutlet weak var ratingStarss: CosmosView!
    
    @IBOutlet weak var goButton: UIButton!
    var markerTapped = false
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
    var userCurrentLocation = CLLocation(latitude: 42.664878, longitude: 21.158634)
    var sortedLocations = [LocationModel]()
    var polyline: GMSPolyline?
    
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
            
        }
        for index in obj.locationArray{
            let locationDistance = CLLocation(latitude: index.latitude, longitude: index.longitude)
            
            distanca = userCurrentLocation.distance(from: locationDistance)
            let distancaNeKilometra = (distanca / 1000)
            let roundDistance = String(format:"%.02f", distancaNeKilometra)
            distanceArray.append(distanca)
            
        }
         sortedLocations.append(contentsOf: obj.locationArray)
         goButton.frame = CGRect(x: 310, y: 160, width: 30, height: 30)
         self.view.addSubview(goButton)
         goButton.isHidden = true
         Xbutton.isHidden = true
        print("\(sortedLocations) ciu ciucci uci uci cuciuci uc **************************")
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        if markerTapped == false {
         goButton.isHidden = false
         Xbutton.isHidden = false
         markerTapped = true
        } else {
           goButton.isHidden = true
           Xbutton.isHidden = true
            markerTapped = false
        }
        return true
    }
    @IBAction func cancelDirection(_ sender: Any) {
        polyline?.map = nil
    }
    
    func getData(){
        Alamofire.request(url!).responseJSON{ response in
            if let JSON = response.result.value{
                
                let mapResponse: [String : Any] = JSON as! [String: Any]
                
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
    
    @IBAction func showDirection(_ sender: UIButton) {
//        if sender.touchesEnded(Set<UITouch>, with: UIEvent?){
//
//        }
        getData()
    }
    func addPolyLine(encodedString: String) {
        
        let path = GMSMutablePath(fromEncodedPath: encodedString)
        polyline = GMSPolyline(path: path)
        polyline?.strokeWidth = 5
        
        polyline?.strokeColor = .blue
    
        polyline?.map = mapView
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "celliJon") as? LocationCell{

        
                cell.mbusheListen(locations: sortedLocations[indexPath.row])
                cell.updateDistancen(distance: distanceArray[indexPath.row])
            if cell.fotoELokalit.image == nil {
                cell.fotoELokalit.af_setImage(withURL: URL(string: sortedLocations[indexPath.row].updatePhoto())!)
            }
        tableView.rowHeight = 120
        
            
            return cell}
        else{ return UITableViewCell()}
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsVC", sender: sortedLocations[indexPath.row])
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsVC"{
            let detail = segue.destination as! DetailLocationVController
            detail.obj = sender as? LocationModel
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedLocations.count
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
        let location: CLLocation = locations.last!
            distanceArray = []
        print("Locations : \(location)")
            for index in obj.locationArray{
            let locationDistance = CLLocation(latitude: index.latitude, longitude: index.longitude)
            distanca = userCurrentLocation.distance(from: locationDistance)
            let distancaNeKilometra = (distanca / 1000)
            let roundDistance = String(format:"%.02f", distancaNeKilometra)
            distanceArray.append(distanca)
            
                
            }
            distanceArray = distanceArray.sorted(by: <)
            
            sortedLocations = []
            for index in distanceArray {
                
                
                for cdex in obj.locationArray{
                    print(index)
                    
                    let locationDistance = CLLocation(latitude: cdex.latitude, longitude: cdex.longitude)
                    print(userCurrentLocation.distance(from: locationDistance))
                    if userCurrentLocation.distance(from: locationDistance) == index{
                        sortedLocations.append(cdex)
                      print(sortedLocations)
                        print("sadasdasdsadsdas")
                        
                    }
                }
            }
            tableView.reloadData()
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
//            _ = String(location.coordinate.latitude)
//            _ = String(location.coordinate.longitude)
       }

        let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude), zoom: zoomLevel)
            
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0 , right: 0)
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




