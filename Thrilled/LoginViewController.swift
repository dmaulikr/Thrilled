//
//  LoginViewController.swift
//  Thrilled
//
//  Created by Deborah on 8/6/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signinButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var termsofserviceButton: UIButton!
    
    @IBAction func signinAction(_ sender: Any) {
        
        login()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Border Colors For Text Fields
        
        let myColor = UIColor(red: 0.17, green: 0.77, blue: 0.99, alpha: 1.0)
        emailField.layer.borderColor = myColor.cgColor
        passwordField.layer.borderColor = myColor.cgColor
        
    }
    
    func login() {
        
        if self.emailField.text == "" || self.passwordField.text == "" {
            
            //Show Error
            
            SVProgressHUD.showError(withStatus: "Please Enter Your Info!")
            
        } else {
            
            //Sign in
            
            SVProgressHUD.setStatus("Signing In...")
            
            Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                if error == nil {
                    
                    SVProgressHUD.dismiss()
                    
                    //Go To Controller
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeView")
                    self.present(vc!, animated: true, completion: nil)
                }
            })
        }
    }
   
} // End Class
