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
        navigationController?
            .popViewController(animated: true)
        
        setUserInfoStruct.setUserInfo(uid: Auth.auth().currentUser!.uid)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Hides unused cells.
        tableView.tableFooterView = UIView()
        
        // Remove lines between cells.
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.reloadData()
        
    }

    // MARK: Helper func: save user info.
    func saveUserInfo() {
        let privateDataRef = FireStoreReferenceManager.referenceForUserPrivateData(uid: Auth.auth().currentUser!.uid)
        
        // Get cell text values
        var inputs = [String]()
        
        // Get text value from username cell.
        let pictureUserCell = tableView.cellForRow(at: IndexPath(row:0, section: 0)) as! ProfileTableViewCell
            inputs.append("\(pictureUserCell.CellNameField.text!)")
        
        // Get text value from introduction cell.
        let introductionCell = tableView.cellForRow(at: IndexPath(row:1, section: 0)) as! ProfileDescriptionTableViewCell
            inputs.append("\(introductionCell.cellTextView.text!)")
        
        // Get text values from info cells.
        for cell in 2..<7 {
            let index = IndexPath(row:cell, section: 0)
            print("idx", cell)
            let cell = tableView.cellForRow(at: index) as! ProfileIdentityInfoTableViewCell
            inputs.append("\(cell.CellTextField.text!)")

        }
        print("inputs!", inputs)
        
        // Set new User Data
        privateDataRef.setData([
            "username": inputs[0],
            "introduction": inputs[1],
            "lastname" : inputs[2],
            "firstname": inputs[3],
            "phone": inputs[4],
            "email": inputs[5],
            "password": inputs[6]
            ])
        
        self.tableView.reloadData()
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
