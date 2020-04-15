//
//  AccountViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/9/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit


class AccountViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(setUserInfoClass.firstname, "da first name")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Hides unused cells.
        tableView.tableFooterView = UIView()
        
        
    }
    
    
    
}

extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // - First Cell, the Profile Cell.
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Account Profile Cell") as! AccountProfileTableViewCell
            cell.setCellLabelandImage()
            
            return cell
        }
        
        // - Other cells, User Options
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Account Cell") as! AccountMenuTableViewCell
        cell.setCellLabel(index: indexPath.row)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            performSegue(withIdentifier: "Profile Page Segue", sender: self)
        } else if indexPath.row == 1 {
            performSegue(withIdentifier: "Delivery Map Segue", sender: self)
        } else if indexPath.row == 2 {
            performSegue(withIdentifier: "Payment Methods Segue", sender: self)
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DeliveryMapViewController {
            //tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    
    
    
    // - MARK: Row heights.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 125.0
        }
        
        return 55.0
    }
}
