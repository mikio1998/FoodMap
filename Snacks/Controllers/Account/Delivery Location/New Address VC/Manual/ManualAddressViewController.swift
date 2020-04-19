//
//  ManualAddressViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/17/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit

class ManualAddressViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        print("Pressed!")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Remove lines between cells.
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
       
    }
    


}

extension ManualAddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellLabelsArray = ["Name", "Description", "郵便番号", "都道府県", "市区町村", "番地", "他"]
        
        // Images Cell
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "New Manual Address Screen Images Cell", for: indexPath)
            return cell
        }
        
        // Textfield Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "New Manual Address Screen Text Field Cell", for: indexPath) as! NewManualAddressScreenTextFieldCell
        cell.setCellLabel(label: cellLabelsArray[(indexPath.row)-1])
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 90.0
        }
        
        return 67.0
    }
    
    
}

