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
    @IBOutlet weak var starRating1: CosmosView!
    @IBOutlet weak var starRating2: CosmosView!
    @IBOutlet weak var starRating3: CosmosView!
    @IBOutlet weak var starRating4: CosmosView!
    @IBOutlet weak var starRating5: CosmosView!
    @IBOutlet weak var starRating7: CosmosView!
    @IBOutlet weak var starRating8: CosmosView!
    @IBOutlet weak var ratingValueLbl1: UILabel!
    @IBOutlet weak var ratingValueLbl2: UILabel!
    @IBOutlet weak var ratingValueLbl3: UILabel!
    @IBOutlet weak var ratingValueLbl4: UILabel!
    @IBOutlet weak var ratingValueLbl5: UILabel!
    @IBOutlet weak var ratingValueLbl6: UILabel!
    @IBOutlet weak var ratingValueLbl7: UILabel!
    @IBOutlet weak var ratingValueLbl8: UILabel!
    @IBOutlet weak var starRating6: CosmosView!
    @IBOutlet weak var ratingValueLbl: UILabel!
    
    var obj : LocationModel?
    var rating: CosmosView?
    
    var a : (Double) = 0
    var b : (Double) = 0
    var c : (Double) = 0
    var d : (Double) = 0
    var e : (Double) = 0
    var f : (Double) = 0
    var g : (Double) = 0
    var l : (Double) = 0
    var m : (Double) = 0
    
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
        
       var arrayOfRatings: [Double]?
        
        starRating.didFinishTouchingCosmos = { rating in
            
            
            self.ratingValueLbl.text = "\(rating)"
            self.a = rating
            }
        starRating1.didFinishTouchingCosmos = {rating1 in
            self.ratingValueLbl1.text = "\(rating1)"
            self.b = rating1
            
        }
        starRating2.didFinishTouchingCosmos = {rating2 in
            self.ratingValueLbl2.text = "\(rating2)"
            self.c = rating2
//            if starRating2.didChangeValue(for: KeyPath<CosmosView, Value){
            
                
            //}
        }
        starRating3.didFinishTouchingCosmos = {rating3 in
            self.ratingValueLbl3.text = "\(rating3)"
            self.d = rating3
          
        }
        starRating4.didFinishTouchingCosmos = {rating4 in
            self.ratingValueLbl4.text = "\(rating4)"
            self.e = rating4
        }
        
        starRating5.didFinishTouchingCosmos = {rating5 in
            self.ratingValueLbl5.text = "\(rating5)"
            self.f = rating5
        }
        starRating6.didFinishTouchingCosmos = {rating6 in
            self.ratingValueLbl6.text = "\(rating6)"
            self.g = rating6
        }
        starRating7.didFinishTouchingCosmos = {rating7 in
            self.ratingValueLbl7.text = "\(rating7)"
            self.l = rating7
        }
        starRating8.didFinishTouchingCosmos = {rating8 in
            self.ratingValueLbl8.text = "\(rating8)"
            self.m = rating8
        }
        let sum = (self.a + self.b + self.c + self.d + self.e + self.f + self.g + self.l + self.m) / 9
        overallRating.text = "\(sum)"
    }
}

