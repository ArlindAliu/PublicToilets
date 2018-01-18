//
//  DetailLocationVController.swift
//  MapTest1
//
//  Created by Arlind Aliu on 12/23/17.
//  Copyright © 2017 Arlind Aliu. All rights reserved.
//

import UIKit

class DetailLocationVController: UIViewController {

    @IBOutlet weak var emriLbl: UILabel!
    @IBOutlet weak var pershkrimiLbl: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var viewHeight: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var overallRating: UILabel!
    
    var obj : LocationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emriLbl.text = obj?.emri
        pershkrimiLbl.text = obj?.pershkrimi
        overallRating.text = obj?.rating
        
        scrollView.contentSize.equalTo(scrollView.frame.size)
        
    }
    
   
    

}
