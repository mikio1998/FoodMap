//
//  ViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/7/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//
//        // Set up video in the background
//        setUpVideo()
//    }
    
    func setUpElements() {
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        
    }
    
    
    

}

