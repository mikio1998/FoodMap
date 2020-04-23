//
//  ProfileViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/14/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    

    @IBAction func saveBarButtonPressed(_ sender: Any) {
        saveUserInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Hides unused cells.
        tableView.tableFooterView = UIView()
        
        // Remove lines between cells.
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    
    
    
    func saveUserInfo() {
        let privateDataRef = FireStoreReferenceManager.referenceForUserPrivateData(uid: Auth.auth().currentUser!.uid)
        
        var inputs = [String]()
        // Get text values from info cells.
        for cell in 2..<7 {
            let index = IndexPath(row:cell, section: 0)
            print("idx", cell)
            let cell = tableView.cellForRow(at: index) as! ProfileIdentityInfoTableViewCell
            print(cell.CellTextField.text!)
            inputs.append("\(cell.CellTextField.text!)")

        }
        print("inputs!", inputs)
        
        
        
        
//        privateDataRef.getDocument { (DocumentSnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                let lastName = DocumentSnapshot?.get("lastname")
//                let firstName = DocumentSnapshot?.get("firstname")
//                let email = DocumentSnapshot.get("email")
//
//
//            }
//        }
    }
    
    
    
    
}




extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // - First Cell, the Profile Cell.
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Profile Cell") as! ProfileTableViewCell
            
            cell.setCellNameFieldandImage()
            cell.backgroundView = UIImageView(image: UIImage(named: "izu-stone"))
            return cell
        } else if indexPath.row == 1 {
            // - Second Cell, the Profle Description Cell.
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Profile Description Cell") as! ProfileDescriptionTableViewCell
            cell.setUpCellTextView()
            
            return cell
        }
        // - Remaining Cells are Identity Info Cells.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Profile Identity Info Cell") as! ProfileIdentityInfoTableViewCell
        cell.setCellLabelandHolder(index: indexPath.row)
        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 210.0
        } else if indexPath.row == 1 {
            return 110.0
        }
        
        return 45.0
    }
    
    
    
    
    
    
    
    
    
}
