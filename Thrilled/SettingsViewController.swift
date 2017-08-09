//
//  SettingsViewController.swift
//  Thrilled
//
//  Created by Deborah on 8/6/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SVProgressHUD

class SettingsViewController: UITableViewController, UITextFieldDelegate {
    
    var refUsers: DatabaseReference!

    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var phoneField: UITextField!
    
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
        
        //Customize Navigation Bar
        
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false

        //Side Menu
        
        sideMenu()
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
        
        //Add User Data
        
        if let key = refUsers.childByAutoId().key {
            SVProgressHUD.showSuccess(withStatus: "Saved!")
            
             let user = ["id": key, "Email": emailField.text! as String, "Password": passwordField.text! as String, "Phone Number": phoneField.text! as String]
            
            refUsers.child(key).setValue(user)
        } else {
            
        }
    }
    
    //Close Keyboard With Tap
    
    func dismissKeyboard() {
        
        //Close On Tap
        
        view.endEditing(true)
    }

} // End Class
