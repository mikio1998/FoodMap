//
//  OnboardingViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/10/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//





import UIKit

class OnboardingViewController: UIViewController, OnboardingPageViewControllerDelegate {
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet var skipButton: UIButton!
    
    // MARK: - Properties
    
    // Use reference of onboardingPageViewController to get current index of onboarding screen.
    // The containerView connects w/ onboardingPageVC through an embed segue.
    // Thus, can access the current index through prepare segue.
    var onboardingPageViewController: OnboardingPageViewController?
    
    @IBAction func skipButtonTapped(sender: UIButton) {
        // Tell userdefaults that onboarding tutorial has been done before.
        UserDefaults.standard.set(true, forKey: "hasViewedOnboarding")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        if let index = onboardingPageViewController?.currentIndex {
            switch index {
            case 0...1:
                onboardingPageViewController?.forwardPage()
            case 2:
                // Tell userdefaults that onboarding tutorial has been done before.
                UserDefaults.standard.set(true, forKey: "hasViewedOnboarding")
                dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
        
        updateUI()
    }
    
    // MARK: - Helper
    func updateUI() {
        if let index = onboardingPageViewController?.currentIndex {
            switch index {
            case 0...1:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle("Get Started!", for: .normal)
                skipButton.isHidden = true
            default:
                break
            }
        pageControl.currentPage = index
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    
    // Setting up the onboardingPageViewController Property as instance of the current onboardingPageVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? OnboardingPageViewController {
            onboardingPageViewController = pageViewController
            onboardingPageViewController?.onboardingDelegate = self
        } // Now, the current onboardingPageViewController is instantiated.
    }
    
    

}
