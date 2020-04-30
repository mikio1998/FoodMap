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
        
        //Unwind To Address Management
        let index = IndexPath(row: 1, section: 0)
        let nameCell = tableView.cellForRow(at: index) as! NewManualAddressScreenTextFieldCell
        
        if nameCell.textField.text!.isEmpty == true {
            nameCell.errorLabel.alpha = 1
            nameCell.errorLabel.textColor = .red
            nameCell.errorLabel.text = "* 必須 *"
        } else {
            performSegue(withIdentifier: "Unwind To Address Management", sender: self)
        }
    }
    
    var MapResults: [String] = []
    var MapCoordinates: [Double] = [0.0, 0.0]
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        mapCoordinatesLabel.text = "\(MapCoordinates[0]), \(MapCoordinates[1])"
    
        // Remove lines between cells.
        //self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        // Hides unused cells.
        tableView.tableFooterView = UIView()
        
        print("MapResults", MapResults)
        
    }
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! AddressManagementViewController
        
        // Helper function: does firebase tasks.
        saveToDB()
        
        print("Before Remove", destinationVC.savedStonesArray)
        destinationVC.savedStonesArray.removeAll()
        print("After Remove", destinationVC.savedStonesArray)
        destinationVC.firestoreToArray()

    }
    
    
    // MARK: - Save to DB helper
    // Write the textField values into
    // a new FireBase Document
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
        
        // Create new stone
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

        
        // MARK: Description Cell
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "New Manual Address Screen Images Cell", for: indexPath)
            return cell
        }
        // MARK: Description Cell
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "New Manual Address Description Cell", for: indexPath) as! NewManualAddressDescriptionTableViewCell
            cell.setUpCellTextView(descriptionText: "")
            
            return cell
        }
        
        // Textfield Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "New Manual Address Screen Text Field Cell", for: indexPath) as! NewManualAddressScreenTextFieldCell
        
        switch indexPath.row {
        case 1:
            cell.setCellLabel(label: "名前", text: "")
            return cell
        // skip case 2
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
        if indexPath.row == 0 { // image cell
            return 100.0
        } else if indexPath.row == 2 { // description cell
            return 105.0
        }
        
        return 58.0
    }
    
    
}

