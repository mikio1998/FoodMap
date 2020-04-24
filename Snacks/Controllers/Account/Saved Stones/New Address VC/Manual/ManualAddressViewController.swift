//
//  ManualAddressViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/17/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class ManualAddressViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        print("Pressed!")
        saveToDB()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Remove lines between cells.
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
       
    }
    
    func saveToDB() {

        let stonesRef = FireStoreReferenceManager.referenceForUserPublicData(uid: Auth.auth().currentUser!.uid).collection("stones")
        
        var inputs = [String]()
        
        // Get the cells.
        // Should iterate in order.
        for cell in 1..<8 {
            let ndx = IndexPath(row:cell, section: 0)
            let cell = tableView.cellForRow(at: ndx) as! NewManualAddressScreenTextFieldCell

            print("\(cell.textField.text!)")
            
            inputs.append("\(cell.textField.text!)")
        }
        
        
        let newStone =
            Stone(name: inputs[0],
                  description: inputs[1],
                  都道府県: inputs[3],
                  市区町村: inputs[4],
                  郵便番号: inputs[2],
                  番地: inputs[5],
                  other: inputs[6])

        print(newStone)
        
        // Add new entry to sales track.
        stonesRef.document(newStone.name).setData([
            "name": newStone.name,
            "description": newStone.description,
            "都道府県": newStone.都道府県,
            "市区町村": newStone.市区町村,
            "郵便番号": newStone.郵便番号,
            "番地": newStone.番地,
            "other": newStone.other
        
        ])

        
        // Dismiss modal on tap.
        //self.dismiss(animated: true, completion: nil)
        
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
            return 100.0
        }
        
        return 73.0
    }
    
    
}

