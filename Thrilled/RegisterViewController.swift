//
//  RegisterViewController.swift
//  Thrilled
//
//  Created by Deborah on 8/8/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    @IBAction func registerButton(_ sender: Any) {
        
        register()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Border Colors For Text Fields
        
        let myColor = UIColor.black
        emailField.layer.borderColor = myColor.cgColor
        passwordField.layer.borderColor = myColor.cgColor
        
        emailField.layer.borderWidth = 1.0
        passwordField.layer.borderWidth = 1.0
        
        //Placeholder Color
        
        emailField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName : UIColor.black])
        
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : UIColor.black])
    }
    
    func register() {
        
        //Error
        
        if emailField.text == "" || passwordField.text == "" {
            
            SVProgressHUD.showError(withStatus: "Please Enter Your Info!")
            
        } else {
            
            //Login
            
            SVProgressHUD.show(withStatus: "Creating User...")
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
                if error == nil {
                    
                    SVProgressHUD.dismiss()
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeView")
                    self.present(vc!, animated: true, completion: nil)
                }
            })
        }
    }


} // End Class
