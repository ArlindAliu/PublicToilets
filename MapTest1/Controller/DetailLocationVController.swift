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
        
        
//        scrollView.addSubview(viewHeight)
//        scrollView.contentSize = viewHeight.bounds.size
//        scrollView.contentOffset = CGPoint(x: 1000, y: 450)
//        self.view.addSubview(scrollView)
//        scrollView.contentSize = CGSize(width: 375, height: 370.5)
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
    }

}
