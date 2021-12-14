//
//  ViewController.swift
//  StartupProject
//
//  Created by Hiral Jotaniya on 10/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var lblEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    
    func authValidation() -> Bool{
        let checkEmail = lblEmail.validatedText(validationType: ValidatorType.email)
        let password = lblPassword.validatedText(validationType: ValidatorType.password)
        
        if (!checkEmail.0){
            Toast.show(message: checkEmail.1, state: .failure)
            return checkEmail.0
        }else if (!password.0){
            Toast.show(message: password.1, state: .failure)
            return password.0
        }
        return true
    }
        
    @IBAction func btnSignIn(_ sender: UIButton) {
        if authValidation(){
            Toast.show(message: "Welcome to startup project :) ", state: .success)
        }
    }
    
}

