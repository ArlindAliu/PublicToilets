//
//  DetailLocationVController.swift
//  MapTest1
//
//  Created by Arlind Aliu on 12/23/17.
//  Copyright © 2017 Arlind Aliu. All rights reserved.
//

import UIKit
import GoogleMaps

protocol RatingDelegate {
    
    func ratingValue(ratingTxt: String)
    
}

class DetailLocationVController: UIViewController , GMSMapViewDelegate{

    @IBOutlet weak var emriLbl: UILabel!
    @IBOutlet weak var pershkrimiLbl: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var stackView: UIStackView!
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
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    var obj : LocationModel?
    var rating: CosmosView?
    var didTouched = false
    var delegate : RatingDelegate?
    
    var sum = Double()
    var dic = [String:Double]()
    var a : (Double) = 0 {
        didSet {
            
           sum = 0
           dic["numri1"] = a
            for (_,j) in dic{
                sum = sum + j
            }
            let roundii = round((sum / Double(dic.count)) * 10) / 10
            
            
            overallRating.text = "\(roundii)"
            obj?.rating = "\(roundii)"
            delegate?.ratingValue(ratingTxt: "\(roundii)")
            }
    }
    var b : (Double) = 0{
        didSet {
            
            sum = 0
            dic["numri2"] = b
            for (_,j) in dic{
                sum = sum + j
            }
            let roundii = round((sum / Double(dic.count)) * 10) / 10
            
            
            overallRating.text = "\(roundii)"
            obj?.rating = "\(roundii)"
            delegate?.ratingValue(ratingTxt: "\(roundii)")
        }
    }
    var c : (Double) = 0{
        didSet {
            
            sum = 0
            dic["numri3"] = c
            for (_,j) in dic{
                sum = sum + j
            }
            let roundii = round((sum / Double(dic.count)) * 10) / 10
            
            
            overallRating.text = "\(roundii)"
            obj?.rating = "\(roundii)"
            delegate?.ratingValue(ratingTxt: "\(roundii)")
        }
    }
    var d : (Double) = 0{
        didSet {
            
            sum = 0
            dic["numri4"] = d
            for (_,j) in dic{
                sum = sum + j
            }
            let roundii = round((sum / Double(dic.count)) * 10) / 10
            
            
            overallRating.text = "\(roundii)"
            obj?.rating = "\(roundii)"
            delegate?.ratingValue(ratingTxt: "\(roundii)")
        }
    }
    var e : (Double) = 0{
        didSet {
            
            sum = 0
            dic["numri5"] = e
            for (_,j) in dic{
                sum = sum + j
            }
            let roundii = round((sum / Double(dic.count)) * 10) / 10
            
            
            overallRating.text = "\(roundii)"
            obj?.rating = "\(roundii)"
            delegate?.ratingValue(ratingTxt: "\(roundii)")
        }
    }
    var f : (Double) = 0{
        didSet {
            
            sum = 0
            dic["numri6"] = f
            for (_,j) in dic{
                sum = sum + j
            }
            let roundii = round((sum / Double(dic.count)) * 10) / 10
            
            
            overallRating.text = "\(roundii)"
            obj?.rating = "\(roundii)"
            delegate?.ratingValue(ratingTxt: "\(roundii)")
        }
    }
    var g : (Double) = 0{
        didSet {
            
            sum = 0
            dic["numri7"] = g
            for (_,j) in dic{
                sum = sum + j
            }
            let roundii = round((sum / Double(dic.count)) * 10) / 10
            
            
            overallRating.text = "\(roundii)"
            obj?.rating = "\(roundii)"
            delegate?.ratingValue(ratingTxt: "\(roundii)")
        }
    }
    var l : (Double) = 0{
        didSet {
            
            sum = 0
            dic["numri8"] = l
            for (_,j) in dic{
                sum = sum + j
            }
            let roundii = round((sum / Double(dic.count)) * 10) / 10
            
            
            overallRating.text = "\(roundii)"
            obj?.rating = "\(roundii)"
            delegate?.ratingValue(ratingTxt: "\(roundii)")
        }
    }
    var m : (Double) = 0{
        didSet {
            
            sum = 0
            dic["numri9"] = m
            for (_,j) in dic{
                sum = sum + j
            }
            let roundii = round((sum / Double(dic.count)) * 10) / 10
            
            
            overallRating.text = "\(roundii)"
            obj?.rating = "\(roundii)"
            delegate?.ratingValue(ratingTxt: "\(roundii)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emriLbl.text = obj?.emri
        pershkrimiLbl.text = obj?.pershkrimi
        overallRating.text = obj?.rating
        mapView.camera = (obj?.camera)! 
        self.mapView.delegate = self
        
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
    
    func ratingStars(){
        
      
        
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
        
        
    }
}

