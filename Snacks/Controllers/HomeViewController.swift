//
//  HomeViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/7/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit


class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.hidesBarsOnSwipe = true
//    }
    
    
    // - OnboardingViewController
    // viewDidAppear will automatically be called by iOS
    override func viewDidAppear(_ animated: Bool) {
        
        
        // Check if Onboarding is already complete in UserDefaults.
        if UserDefaults.standard.bool(forKey: "hasViewedOnboarding") {
            return
        }
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let onboardingViewController = storyboard.instantiateViewController(identifier: "OnboardingViewController") as? OnboardingViewController {
            //print(onboardingViewController)
            present(onboardingViewController, animated: true, completion: nil)
        }
        
    }
    
    
}
