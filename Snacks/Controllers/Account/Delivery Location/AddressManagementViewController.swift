//
//  AddressManagementViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/17/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit

class AddressManagementViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Hides unused cells.
        tableView.tableFooterView = UIView()
    }

}


extension AddressManagementViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // later, read data from FireStore
        let testCount = 2
        
        return testCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "My Address Cell", for: indexPath) as! MyAddressCell
        
        cell.setCellElements(name: "Person \(indexPath.row)", address: "123-4567 Down the road", lastvisited: "Last Visited: 4/11 2020", image: "izu-stone")
        
        return cell
        
    }
    
    // - Did select row
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        tableView.deselectRow(at: indexPath, animated: true)
//        //self.selectedIndex = indexPath.row
//        performSegue(withIdentifier: "", sender: Any?.self)
//
//    }
    
    
    
    // - Row Heights
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return 225.0
//        }
        
        return 225.0
    }
        
    
    
    
}
