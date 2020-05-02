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



struct Location {
    var selectName: String
    var selectCoordinates: [Double] = [35.681708, 139.767053]
    var selectFormattedAddress: [String] = ["Tokyo", "Japan"]
}

class ManualAddressViewController: UIViewController {

    var location: Location? {
        didSet {
            print("Didset")
            print(location?.selectFormattedAddress)
        }
        willSet {
            print("willset")
        }
    }
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mapCoordinatesLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        print("Save Pressed")
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
    
    
    // MARK: DATA HOLDING VARIABLES
    var AddressData: [String] = []
    var MapCoordinates: [Double] = [0.0, 0.0]
    
    // Current editing cell
    var EditingCellAt: Int = 0

    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate Location@^
        location = Location(selectName: "", selectCoordinates: MapCoordinates, selectFormattedAddress: AddressData)
        print("LOCATION",location)
        
        

        tableView.delegate = self
        tableView.dataSource = self
        mapCoordinatesLabel.text = "\(MapCoordinates[0]), \(MapCoordinates[1])"
    
        // Remove lines between cells.
        //self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        // Hides unused cells.
        tableView.tableFooterView = UIView()
        
        print("AddressData", AddressData)
        
    }
    // MARK: - PREPARE for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! AddressManagementViewController
        
        // MARK: Helper function: does firebase tasks.
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
        
        //MARK: TODO: Get data from AddressData
        
        // Get the cells.
        // Should iterate in order.
        for cell in 1..<8 {
            
            switch cell {
            case 2:
                let ndx = IndexPath(row:cell, section: 0)
                let cell = tableView.cellForRow(at: ndx) as! NewManualAddressDescriptionTableViewCell
                    
                print("\(cell.cellTextView.text!)")
            default:
                let ndx = IndexPath(row:cell, section: 0)
                print(ndx.row)
                let cell = tableView.cellForRow(at: ndx) as! NewManualAddressScreenTextFieldCell
                print("\(cell.textField.text!)")
                inputs.append("\(cell.textField.text!)")
            }
            
            
            
//            if cell == 2 { // Description TextView
//                let ndx = IndexPath(row:cell, section: 0)
//                let cell = tableView.cellForRow(at: ndx) as! NewManualAddressDescriptionTableViewCell
//
//                print("\(cell.cellTextView.text!)")
//                inputs.append("\(cell.cellTextView.text!)")
//            } else {
//                let ndx = IndexPath(row:cell, section: 0)
//                let cell = tableView.cellForRow(at: ndx) as! NewManualAddressScreenTextFieldCell
//                print("\(cell.textField.text!)")
//                inputs.append("\(cell.textField.text!)")
//            }
            

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
            
            cell.cellTextView.tag = indexPath.row
            
            cell.cellTextView.delegate = self

            cell.setUpCellTextView(descriptionText: location?.selectFormattedAddress[1] ?? "")
            
            print(cell.cellTextView.tag)
            return cell
        }
        
        // Textfield Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "New Manual Address Screen Text Field Cell", for: indexPath) as! NewManualAddressScreenTextFieldCell

        // TODO: Do case7 check for all cells (in case for short address)
        
        switch indexPath.row {
        case 1:
//            cell.setCellLabel(label: "名前", text: AddressData[0])
            cell.textField.tag = indexPath.row
            cell.textField.delegate = self
            
            cell.setCellLabel(label: "名前", text: location?.selectFormattedAddress[0] ?? "")
            return cell
        // skip case 2
        case 3:
            
            cell.textField.tag = indexPath.row
            cell.textField.delegate = self
            cell.setCellLabel(label: "住所1", text: location?.selectFormattedAddress[2] ?? "")
            
            return cell
        case 4:
            
            cell.textField.tag = indexPath.row
            cell.textField.delegate = self
            cell.setCellLabel(label: "住所2", text: location?.selectFormattedAddress[3] ?? "")
            return cell
        case 5:
            
            cell.textField.tag = indexPath.row
            cell.textField.delegate = self
            cell.setCellLabel(label: "住所3", text: location?.selectFormattedAddress[4] ?? "")
            return cell
        case 6:
            
            cell.textField.tag = indexPath.row
            cell.textField.delegate = self
            cell.setCellLabel(label: "住所4", text: location?.selectFormattedAddress[5] ?? "")
            return cell
        case 7:
            // Array Range Check.
            //if AddressData.count > 7 {
            if (location?.selectFormattedAddress.count)! > 7 {
                //cell.setCellLabel(label: "住所5", text: AddressData[7])
                cell.textField.tag = indexPath.row
                cell.textField.delegate = self
                cell.setCellLabel(label: "住所5", text: location?.selectFormattedAddress[6] ?? "")
                return cell
            }
            cell.setCellLabel(label: "住所5", text: "")
            return cell
        default:
            cell.setCellLabel(label: "Error fetching Label.", text: "Error fetching Text.")
            return cell
        }
    }
    
//    // MARK: HELPER get cell data.
//    func GetCellTextValues() {
//
//    }
//
//    // MARK: TODO
//    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
//        print("ended editing")
//        // address1 to address5
//        if (3 <= indexPath!.row || indexPath!.row < 8) {
//            let cell = tableView.cellForRow(at: indexPath!) as! NewManualAddressScreenTextFieldCell
//
//            MapResults[indexPath!.row-3] = cell.textField.text!
//            print(MapResults)
//
//        }
//
//    }
    
    // MARK: Cell Sizing
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { // image cell
            return 100.0
        } else if indexPath.row == 2 { // description cell
            return 105.0
        }
        return 158
        //return 58.0
    }
}

// MARK: - VC a Delegate of UITextFieldDelegate
// MARK: Update Address Data when TextView of Cell is edited.
extension ManualAddressViewController: UITextFieldDelegate {
    
    // StackOverflow: UITextField and UITextView disappears after scrolling in tableview?
    // https://stackoverflow.com/questions/46403526/uitextfield-and-uitextview-disappears-after-scrolling-in-tableview
    
    // MARK: * Why not didEndEditing? *
    // In the case when you press save while still edting a textField/View,
    // the delegate method will not be able to trigger.
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        print("Editing Result:", result)
        location?.selectFormattedAddress[textField.tag-1] = result
        print("Updated:", location?.selectFormattedAddress)
        return true
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let result = (textView.text as NSString?)?.replacingCharacters(in: range, with: text) ?? text
//        location?.selectFormattedAddress[textView.tag-1] = result
//        return true
//
//    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let result = (textView.text as NSString?)?.replacingCharacters(in: range, with: text) ?? text
//        location?.selectFormattedAddress[textView.tag-1] = result
//        return true
//    }
    
    // Use didEndEditing to print out changes to Console.
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Ended editing Cell \(textField.tag)")
        print("Updated:", location?.selectFormattedAddress) }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        print("Ended editing Cell \(textView.tag)")
//        print("Updated:", location?.selectFormattedAddress) }
    
    
    
}

// MARK: - VC a Delegate of UITextFieldDelegate
// MARK: Update Address Data when TextField of Cell is edited.
extension ManualAddressViewController: UITextViewDelegate {
    
    
    
    
    // MARK: - TextView placeholder
    // TextView has no placeholder property. So, programatcally added it.
    // https://stackoverflow.com/questions/27652227/how-can-i-add-placeholder-text-inside-of-a-uitextview-in-swift
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText: String
        
        // Aka. If there's no user input.
        if (textView.textColor == UIColor.lightGray) {
            currentText = ""
        } else { // There is user input.
            currentText = textView.text
        }

        
        
        print("CURRENT TEXT:", currentText)
        
        // Make updatedText the Address description data.
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        print("UPDATED TEXT:", updatedText)

        // Update the data. 
        location?.selectFormattedAddress[textView.tag-1] = updatedText
        
        
        // If updatedText will be empty, add the placeholder
        // and set cursor to beginning of textView.
        if updatedText.isEmpty {
            textView.text = "山手線　上野駅西口。。\nお寺の左側、。。"
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.endOfDocument)
        }
        
        // Else, if the textView's placeholder is gray,
        // and replacement string length is greater than zero,
        // set the textColor to black and set text to the replacement string.
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
            // Here, user input updated as Address Description Data.
            
            
            
        }
        // For every other case, the text should change
        // with the usual behavior...
        else {
            print("else")
            
            return true
        }
        // ... otherwise return false since the updates
        // have already been made.
        return false
    }
    
    
    // To prevent the user from changing the cursor position,
    // while the placeholder is visible.
    func textViewDidChangeSelection(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("Ended editing Cell \(textView.tag)")
        print(location?.selectFormattedAddress)
        //print("Updated:", location?.selectFormattedAddress)
        
    }

}

