//
//  SettingsViewController.swift
//  Thrilled
//
//  Created by Deborah on 8/6/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var alertButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Side Menu
        
        sideMenu()
    }

    
    func sideMenu() {
        
        if revealViewController() != nil {
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            
            
            alertButton.target = revealViewController()
            alertButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
    }

} // End Class
