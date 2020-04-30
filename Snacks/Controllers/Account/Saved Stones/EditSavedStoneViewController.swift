//
//  EditSavedStoneViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/18/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class EditSavedStoneViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var saveButton: UIButton!
        
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        
        
        let alert = UIAlertController(title: "Name Required", message: "message", preferredStyle: .alert)
        
        let index = IndexPath(row: 0, section: 0)
        let nameCell = tableView.cellForRow(at: index) as! EditSavedStoneTextCell
        
        if nameCell.textField.text!.isEmpty == true {
            nameCell.errorLabel.alpha = 1
            nameCell.errorLabel.textColor = .red
            nameCell.errorLabel.text = "* Required *"
            
        }
        else {

            performSegue(withIdentifier: "unwindToAddressManagement", sender: self)
        }
        


        
    }


    
    // stoneData holds current stone data values.
    var stoneData: Stone = Stone(name: "", description: "", Address1: "", Address2: "", Address3: "", Address4: "", Address5: "")
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        // Hides unused cells.
        tableView.tableFooterView = UIView()
        
        let index = IndexPath(row: 0, section: 0)
        let NameCell = tableView.cellForRow(at: index) as! EditSavedStoneTextCell
        
        //saveButton.isEnabled = false
 
    }
    
   
    
    
    // MARK: - Prepare for save segue
    // Saved edited stone.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! AddressManagementViewController
        
        // Reference to the stone document.
        let stoneCollectionRef = FireStoreReferenceManager.referenceForUserPublicData(uid: Auth.auth().currentUser!.uid).collection("stones")

        var inputs = [String]()
        // Get text values from cells. Create Stone object with values.
        for cell in 0..<7 {
            let index = IndexPath(row:cell, section: 0)
            //print(tableView.cellForRow(at: index), "cell!")
            let cell = tableView.cellForRow(at: index) as! EditSavedStoneTextCell
            //print(cell.textField.text ?? "")

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

        // TODO: delete old document
        stoneCollectionRef.document(stoneData.name).delete()
        
        // TODO: set new document
        stoneCollectionRef.document(newStone.name).setData([
            "name": newStone.name,
            "description": newStone.description,
            "Address1": newStone.Address1,
            "Address2": newStone.Address2,
            "Address3": newStone.Address3,
            "Address4": newStone.Address4,
            "Address5": newStone.Address5
        ])
        
        // Fill in savedStonesArray with updated stones.
        print("Before Remove", destinationVC.savedStonesArray)
        destinationVC.savedStonesArray.removeAll()
        print("After Remove", destinationVC.savedStonesArray)
        destinationVC.firestoreToArray()

        
    }
    
}

// MARK: - TableView

extension EditSavedStoneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // Cell Labels in array form.
        let labels = [
            "名前",
            "場所の説明",
            "住所１",
            "住所２",
            "住所３",
            "住所４",
            "住所５"]
        
        // Stone data in array form.
        let stone = [
            stoneData.name,
            stoneData.description,
            stoneData.Address1,
            stoneData.Address2,
            stoneData.Address3,
            stoneData.Address4,
            stoneData.Address5]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Edit Saved Stone Text Cell", for: indexPath) as! EditSavedStoneTextCell

        cell.setTextFieldAndLabel(labelText: labels[indexPath.row], fieldText: stone[indexPath.row])

        return cell
    }
    
    // MARK: - Cell size
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}


extension EditSavedStoneViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let images = ["stonepic1", "stonepic2", "stonepic3", "stonepic4", "stonepic5"]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Stone Image Cell", for: indexPath) as! EditSavedStoneCollectionViewCell
        cell.setImage(image: images[indexPath.row])
        
        return cell
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

    
}

extension EditSavedStoneViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
