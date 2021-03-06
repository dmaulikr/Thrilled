//
//  InformationTableViewController.swift
//  Thrilled
//
//  Created by Deborah on 8/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class InformationTableViewController: UITableViewController {

    @IBOutlet var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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



} //End Class
