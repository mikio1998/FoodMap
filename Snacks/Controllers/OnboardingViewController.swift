//
//  OnboardingViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/10/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet var skipButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    

}
