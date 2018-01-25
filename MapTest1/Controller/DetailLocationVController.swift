//
//  DetailLocationVController.swift
//  MapTest1
//
//  Created by Arlind Aliu on 12/23/17.
//  Copyright © 2017 Arlind Aliu. All rights reserved.
//

import UIKit
import GoogleMaps

class DetailLocationVController: UIViewController {

    @IBOutlet weak var emriLbl: UILabel!
    @IBOutlet weak var pershkrimiLbl: UILabel!
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var viewHeight: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var overallRating: UILabel!
    
    @IBOutlet weak var ratingValueLbl: UILabel!
    var obj : LocationModel?
    var rating: CosmosView?
    override func viewDidLoad() {
        super.viewDidLoad()

        emriLbl.text = obj?.emri
        pershkrimiLbl.text = obj?.pershkrimi
        overallRating.text = obj?.rating
        mapView.camera = (obj?.camera)! 
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake((obj?.latitude)!,(obj?.longitude)!)
        marker.title = "\(obj?.emri ?? "")"
        marker.snippet = "\(obj?.tipi ?? "")  "
        marker.map = mapView
        
        ratingStars()
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
    }
    
    func ratingStars(){
        
        starRating.didFinishTouchingCosmos = { rating in
            
            self.ratingValueLbl.text = "\(rating)"
            
            if self.starRating.accessibilityValue == "1" {
                self.ratingValueLbl.text = "1"
            }
        }
    }
    override func accessibilityIncrement() {
        
    }
    override func accessibilityDecrement() {
        
    }
    
}

