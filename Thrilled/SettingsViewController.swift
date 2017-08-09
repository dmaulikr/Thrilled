//
//  SettingsViewController.swift
//  Thrilled
//
//  Created by Deborah on 8/6/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class SettingsViewController: UITableViewController, UITextFieldDelegate {
    
    var refUsers: DatabaseReference!

    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var phoneField: UITextField!
    
    @IBAction func changeEmail(_ sender: Any) {
        
        updateEmail()
    }
    @IBAction func changePassword(_ sender: Any) {
        
        updatePassword()
    }
    @IBAction func deleteAccount(_ sender: Any) {
        
        deleteAccount()
    }
    @IBAction func signOut(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Firebase
        
        refUsers = Database.database().reference().child("Settings")
        
        //Close Keyboard With Return Key
        
        self.emailField.delegate = self
        self.passwordField.delegate = self
        self.phoneField.delegate = self
        
        //Close Keyboard With Tap
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //Border Colors For Text Fields
        
        let myColor = UIColor.init(red: 0.17, green: 0.77, blue: 0.99, alpha: 1.0)
        emailField.layer.borderColor = myColor.cgColor
        passwordField.layer.borderColor = myColor.cgColor
        phoneField.layer.borderColor = myColor.cgColor
        
        emailField.layer.borderWidth = 2.0
        passwordField.layer.borderWidth = 2.0
        phoneField.layer.borderWidth = 2.0
        
        //Customize Navigation Bar
        
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false

        //Side Menu
        
        sideMenu()
    }
    
    func dismissKeyboard() {
        
        //Close Keyboard On Tap
        
        view.endEditing(true)
    }
    
    func sideMenu() {
        
        if revealViewController() != nil {
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    func addUserData() {
        
        //Add User Data To Firebase
        
        if let key = refUsers.childByAutoId().key {
            SVProgressHUD.showSuccess(withStatus: "Saved!")
            
             let user = ["id": key, "Email": emailField.text! as String, "Password": passwordField.text! as String, "Phone Number": phoneField.text! as String]
            
            refUsers.child(key).setValue(user)
        } else {
            
        }
    }
    
    func updateEmail() {
        
        SVProgressHUD.show(withStatus: "Updating Email...")
        
        if let user = Auth.auth().currentUser {
            
            user.updateEmail(to: emailField.text!, completion: { (error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    
                    SVProgressHUD.dismiss()
                    
                } else {
                    
                    SVProgressHUD.dismiss()
                }
            })
        }
    }
    
    func updatePassword() {
        
        
        SVProgressHUD.show(withStatus: "Updating Password...")
        
        if let user = Auth.auth().currentUser {
            
            user.updatePassword(to: passwordField.text!, completion: { (error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    
                    SVProgressHUD.dismiss()
                    
                    SVProgressHUD.showError(withStatus: "Network Error! Update Failed!")
                    
                } else {
                    
                    SVProgressHUD.dismiss()
                }
            })
        }
    }
    
    func deleteAccount() {
        
        SVProgressHUD.show(withStatus: "Deleting Account...")
        
        let user = Auth.auth().currentUser
        user?.delete(completion: { (error) in
            if let error = error {
                
                print(error.localizedDescription)
                
                SVProgressHUD.dismiss()
                
                SVProgressHUD.showError(withStatus: "Failed To Delete Account!")
                
            } else {
                
                SVProgressHUD.dismiss()
            }
        })
    }

} // End Class
