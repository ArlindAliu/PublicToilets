//
//  PickerViewController.swift
//  MapTest1
//
//  Created by Arlind Aliu on 2/15/18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{
    

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var popUpConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var settingsConstraint: NSLayoutConstraint!
    let languages: [String] = ["Shqip","English"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
       popupView.layer.cornerRadius = 10
       popupView.layer.masksToBounds = true
       pickerView.dataSource = self
       pickerView.delegate = self
        
        
    }

    @IBAction func showDropBar(_ sender: Any) {
        settingsConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func showPickerView(_ sender: UIButton) {
        popUpConstraint.constant = 0
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func closeButton(_ sender: Any) {
        popUpConstraint.constant = -400
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
