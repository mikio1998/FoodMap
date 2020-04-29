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
    
    @IBOutlet weak var mapCoordinatesLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        print("Pressed!")
        saveToDB()
    }
    
    var MapResults: [String] = []
    var MapCoordinates: [Double] = [0.0, 0.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        mapCoordinatesLabel.text = "\(MapCoordinates[0]), \(MapCoordinates[1])"
        
        
        // Remove lines between cells.
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        print("MapResults", MapResults)
        
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
                  Address1: inputs[2],
                  Address2: inputs[3],
                  Address3: inputs[4],
                  Address4: inputs[5],
                  Address5: inputs[6])

        print(newStone)
        
        // Add new entry to sales track.
        stonesRef.document(newStone.name).setData([
            "name": newStone.name,
            "description": newStone.description,
            "Address1": newStone.Address1,
            "Address2": newStone.Address2,
            "Address3": newStone.Address3,
            "Address4": newStone.Address4,
            "Address5": newStone.Address5
        
        ])
        
    }
}





extension ManualAddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        // Images Cell
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "New Manual Address Screen Images Cell", for: indexPath)
            return cell
        }
        
        // Textfield Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "New Manual Address Screen Text Field Cell", for: indexPath) as! NewManualAddressScreenTextFieldCell
        
        switch indexPath.row {
        case 1:
            cell.setCellLabel(label: "名前", text: "")
            return cell
        case 2:
            cell.setCellLabel(label: "場所の説明", text: "")
            return cell
        case 3:
            cell.setCellLabel(label: "住所1", text: MapResults[0])
            return cell
        case 4:
            cell.setCellLabel(label: "住所2", text: MapResults[1])
            return cell
        case 5:
            cell.setCellLabel(label: "住所3", text: MapResults[2])
            return cell
        case 6:
            cell.setCellLabel(label: "住所4", text: MapResults[3])
            return cell
        case 7:
            // Array Range Check.
            if MapResults.count > 4 {
                cell.setCellLabel(label: "住所5", text: MapResults[4])
                return cell
            }
            cell.setCellLabel(label: "住所5", text: "")
            return cell
        default:
            cell.setCellLabel(label: "Error fetching Label.", text: "Error fetching Text.")
            return cell
        }
        
        //cell.setCellLabel(label: cellLabelsArray[(indexPath.row)-1], text[])
        
        //return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100.0
        }
        
        return 73.0
    }
    
    
}

