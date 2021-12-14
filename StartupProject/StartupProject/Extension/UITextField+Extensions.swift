//
//  UITextField+Extensions.swift
//  StartupProject
//
//  Created by Hiral Jotaniya on 02/12/21.
//

import UIKit.UITextField

extension UITextField {
    
    func validatedText(validationType: ValidatorType) -> (Bool,String) {
        let validator = ValidatorFactory.validatorFor(type: validationType)
        return validator.validated(self.text!)
    }
    
    func AddLeftView(str : String){
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        let lbl = UILabel(frame: CGRect(x:0, y: 0, width: 20, height: 30))
        lbl.textColor = UIColor.white.withAlphaComponent(0.5)
        lbl.font = FontBook.regular.of(size: 28.0)
        lbl.text = str
        
        lbl.textAlignment = .center
        leftView.addSubview(lbl)
        
        self.leftView = leftView
        self.leftViewMode = .always
    }
    func addInputViewDatePicker(target: Any, selector: Selector ,PickerMode : UIDatePicker.Mode, MinDate : Bool? = false , MaxDate : Bool? = false) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        //Add DatePicker as inputView
        let datePicker = UIDatePicker()//UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
       
            if #available(iOS 14.0, *) {
                datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
            } else {
                // Fallback on earlier versions
            }
        datePicker.minuteInterval = 30
      
        datePicker.datePickerMode = PickerMode
        if PickerMode == .date{
            if MinDate == true{
                datePicker.minimumDate = Date()
            }
            if MaxDate == true{
                datePicker.maximumDate = Date()
            }
        }
       
        
        self.inputView = datePicker
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        
        self.inputAccessoryView = toolBar
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
    }
    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
}
