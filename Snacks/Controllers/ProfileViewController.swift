//
//  ProfileViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/9/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self


    }
    
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // - First Cell, the Profile Cell.
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Account Profile Cell") as! AccountProfileTableViewCell
            cell.setCellLabel()

            return cell
        }
        
        // - Other cells, User Options
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Account Cell") as! AccountTableViewCell
        cell.setCellLabel(index: indexPath.row)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 125.0
        }
        
        return 55.0
    }
}
