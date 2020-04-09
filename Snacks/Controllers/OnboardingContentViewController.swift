//
//  OnboardingContentViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/9/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit

class OnboardingContentViewController: UIViewController {
    
    // MARK: Outlets:
    
    @IBOutlet var headingLabel: UILabel! {
        didSet {
            headingLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var subheadingLabel: UILabel! {
        didSet {
            subheadingLabel.numberOfLines = 0
        }
    }
    @IBOutlet var contentImageView: UIImageView!
    
    
    // MARK: Properties
    var index = 0
    var heading = ""
    var subheading = ""
    var imagefile = ""
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = heading
        subheadingLabel.text = subheading
        contentImageView.image = UIImage(named: imagefile)

        // Do any additional setup after loading the view.
    }
    



}
