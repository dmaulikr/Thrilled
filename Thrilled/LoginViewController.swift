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

        //Border Colors For Buttons & Text Fields
        
        let myColor = UIColor(red: 0.17, green: 0.77, blue: 0.99, alpha: 1.0)
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = myColor.cgColor
        border.frame = CGRect(x: 0, y: emailField.frame.size.height - width, width:  emailField.frame.size.width, height: emailField.frame.size.height)
        
        border.borderWidth = width
        emailField.layer.addSublayer(border)
        emailField.layer.masksToBounds = true
        
        border.borderColor = myColor.cgColor
        border.frame = CGRect(x: 0, y: passwordField.frame.size.height - width, width:  passwordField.frame.size.width, height: passwordField.frame.size.height)
        
        border.borderWidth = width
        passwordField.layer.addSublayer(border)
        passwordField.layer.masksToBounds = true
        
        signinButton.layer.cornerRadius = 10
        signinButton.layer.borderWidth = 1
        signinButton.layer.borderColor = myColor.cgColor
        signinButton.layer.borderWidth = 2.0
        
        registerButton.layer.cornerRadius = 10
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = myColor.cgColor
        registerButton.layer.borderWidth = 2.0
        
        termsofserviceButton.layer.cornerRadius = 10
        termsofserviceButton.layer.borderWidth = 1
        termsofserviceButton.layer.borderColor = myColor.cgColor
        termsofserviceButton.layer.borderWidth = 2.0
        
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
