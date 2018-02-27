//
//  ProvaController.swift
//  MapTest1
//
//  Created by Arlind Aliu on 2/14/18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import UIKit

class ProvaController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var buttoni: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerData : [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        pickerData = ["Language", "About"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    @IBAction func showPickerView(_ sender: Any) {
        
        
    }
    
}
