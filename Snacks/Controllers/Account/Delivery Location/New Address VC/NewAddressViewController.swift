//
//  NewAddressViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/17/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit

class NewAddressViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Hides unused cells.
        tableView.tableFooterView = UIView()
    }
    


}


extension NewAddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Get Address Manually Cell") as! GetAddressManuallyCell
        
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Get Address Current Location Cell") as! GetAddressCurrentLocationCell
        
            return cell
    }
    
    // - Row Heights
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return 225.0
//        }
        
        return 225.0
    }
    
    
    
    
    
}
