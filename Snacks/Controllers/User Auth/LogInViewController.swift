//
//  LogInViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/7/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore


protocol initiateTransitionProtocol {
    func goToHomeVC()
}


struct userInfoObserver {

    // When the logging in user's information is written, initiate transition to HomeVC.
    static var didFinishWritingUserInfo = false
}


class LogInViewController: UIViewController, initiateTransitionProtocol {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!

    
    
    func goToHomeVC() {
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? TabBarController
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpElements()
        
        
        

    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // MARK: - IN PRODUCTION MODE
        // Do not use in distribution
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? TabBarController

        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
        
        
        
        
        
// MARK: - Temporarily deactivated --v--
        
//         // TODO: Validate Text Fields
//
//        // Create cleaned versions of the text field
//        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        // Signing in the user
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//
//            if error != nil {
//                // Couldn't sign in
//                self.errorLabel.text = error!.localizedDescription
//                self.errorLabel.alpha = 1
//            }
//            else {
//
////                // This initialization occurs, but values are still empty. Might need to fix in future.
////                setUserInfoStruct.setUserInfo(uid: (result?.user.uid)!)
////                // Thus, this will print empty string.
////                setUserInfoStruct.printUserInfoToConsole()
//
////                while userInfoObserver.didFinishWritingUserInfo == false {
////                    print("loading")
////                }
//
//                let serialQueue = DispatchQueue(label: "queuename")
//
//                serialQueue.async {
//
//                    // This initialization occurs, but values are still empty. Might need to fix in future.
//                    setUserInfoStruct.setUserInfo(uid: (result?.user.uid)!)
//                    // Thus, this will print empty string.
//                    setUserInfoStruct.printUserInfoToConsole()
//
//                    print("Task 1 started")
//                    // Do some work..
//                    print("Task 1 finished")
//                }
//
//
//
//                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? TabBarController
//
//                self.view.window?.rootViewController = homeViewController
//                self.view.window?.makeKeyAndVisible()
//
//
//            }
//        }
        

    
// MARK: Temporarily deactivated --^--
        
    }
    
    
    
    
    
}
