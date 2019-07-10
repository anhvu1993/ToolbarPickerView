//
//  ViewController.swift
//  CheckpickerView
//
//  Created by Bui Van Tuan on 7/10/19.
//  Copyright © 2019 Nguyen khac vu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textDatePicker: UITextField!
    @IBOutlet weak var textDistrickPicker: UITextField!
    let datePicker = UIDatePicker()
    let districksPicker = UIPickerView()
    let loopingMargin: Int = 30
    let listdistrick = ["Hà nội", "Hải Phòng", "Nam Định", "Hà tĩnh", "Hồ chí Minh", "Hải Dương", "Hà Nam","Nghệ An", "Bắc cạn", "Sơn la"]
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        showdistricks()
        
    }
    @IBAction func cancel(_ sender: Any) {
        self.view.endEditing(true)
    }
}

//MARK : DatePickerView
extension ViewController {
    func showDatePicker(){
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        datePicker.addTarget(self, action: #selector(donedatePicker), for: .valueChanged)
        let doneButton   = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(cancel))
        let spaceButton  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        textDatePicker.inputAccessoryView = toolbar
        textDatePicker.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        textDatePicker.text  = formatter.string(from: datePicker.date)
        //        self.view.endEditing(true)
    }
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}

// MARK: districkPicker
extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func showdistricks() {
        districksPicker.selectRow((loopingMargin / 2) * listdistrick.count, inComponent: 0, animated: false)
        
        districksPicker.dataSource = self
        districksPicker.delegate   = self
        let toolbar     = UIToolbar()
        toolbar.sizeToFit()
        let doneButton  = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donedistrickPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton,doneButton], animated: false)
        textDistrickPicker.inputAccessoryView = toolbar
        textDistrickPicker.inputView          = districksPicker
        
    }
    @objc func donedistrickPicker() {
        self.textDistrickPicker.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return loopingMargin * listdistrick.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listdistrick[row % listdistrick.count]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentIndex = row % listdistrick.count
        districksPicker.selectRow((loopingMargin / 2) * listdistrick.count + currentIndex, inComponent: 0, animated: false)
        textDistrickPicker.text = listdistrick[row % listdistrick.count]
    }
}
