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
        
  
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AddressManagementViewController
        
        
        // Reference to the stone document.
//        let stoneRef = FireStoreReferenceManager.referenceForUserPublicData(uid: Auth.auth().currentUser!.uid).collection("stones").document(stoneData.name)
        let stoneCollectionRef = FireStoreReferenceManager.referenceForUserPublicData(uid: Auth.auth().currentUser!.uid).collection("stones")
        
        
        
        var inputs = [String]()
        // Get text values from cells. Create Stone object with values.
        for cell in 0..<7 {
            let index = IndexPath(row:cell, section: 0)
            //print(tableView.cellForRow(at: index), "cell!")
            let cell = tableView.cellForRow(at: index) as! EditSavedStoneTextCell
            print(cell.textField.text ?? "")

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

        // TODO: delete old document
        stoneCollectionRef.document(stoneData.name).delete()
        
        // TODO: set new document
        stoneCollectionRef.document(newStone.name).setData([
            "name": newStone.name,
            "description": newStone.description,
            "都道府県": newStone.都道府県,
            "市区町村": newStone.市区町村,
            "郵便番号": newStone.郵便番号,
            "番地": newStone.番地,
            "other": newStone.other
        ])
        
        // Fill in savedStonesArray with updated stones.
        destinationVC.firestoreToArray()
    }
    
    //var stoneData: [Stone] = []
    var stoneData: Stone = Stone(name: "", description: "", 都道府県: "", 市区町村: "", 郵便番号: "", 番地: "", other: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        // Hides unused cells.
        tableView.tableFooterView = UIView()
    }

}

extension EditSavedStoneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // Cell Labels in array form.
        let labels = [
            "Name",
            "Description",
            "郵便番号",
            "都道府県",
            "市区町村",
            "番地",
            "other"]
        
        // Stone data in array form.
        let stone = [
            stoneData.name,
            stoneData.description,
            stoneData.郵便番号,
            stoneData.都道府県,
            stoneData.市区町村,
            stoneData.番地,
            stoneData.other]
        
        
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
