//
//  ProfileViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/14/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Hides unused cells.
        tableView.tableFooterView = UIView()
    }
    


}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // - First Cell, the Profile Cell.
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Profile Cell") as! ProfileTableViewCell
            
            cell.setCellNameFieldandImage()
            
            return cell
        }
        
        // - Second Cell, the Profle Description Cell.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Profile Description Cell") as! ProfileDescriptionTableViewCell
        //cell.setCellLabel(index: indexPath.row)
        cell.setCellTextFieldPlaceholder()
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 265.0
        }
        
        return 155.0
    }
}
