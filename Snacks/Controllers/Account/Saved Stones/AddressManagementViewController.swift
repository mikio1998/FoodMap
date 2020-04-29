//
//  AddressManagementViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/17/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class AddressManagementViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    // Stone Data
    //var savedStonesArray = [Dictionary<String, String>]()
    //var savedStoneNames: [String] = []
    
    
    var savedStonesArray: [Stone] = []

    var selectedStone: Stone = Stone(name: "", description: "", Address1: "", Address2: "", Address3: "", Address4: "", Address5: "")
    
    
    // Func that unwinds VC's to this VC.
    // To pass data: https://www.youtube.com/watch?v=ULd2v4mHyQ4
    @IBAction func unwindToAddressManagement(_ sender: UIStoryboardSegue) {
        
        // When unwind is triggered, reload the data.
        self.firestoreToArray()
        self.tableView.reloadData()
    }
        

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Hides unused cells.
        tableView.tableFooterView = UIView()
        
        // Remove lines between cells.
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        firestoreToArray()
    }
    
    
    func firestoreToArray() {
        
        // Empty the savedStonesArray every time called.
        // Removes duplcates after changes.
        self.savedStonesArray.removeAll()
        
        let stonesRef = FireStoreReferenceManager.referenceForUserPublicData(uid: Auth.auth().currentUser!.uid).collection("stones")

        stonesRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let Name = document.get("name") as! String
                    let Description = document.get("description") as! String
                    let Address1 = document.get("Address1") as! String
                    let Address2 = document.get("Address2") as! String
                    let Address3 = document.get("Address3") as! String
                    let Address4 = document.get("Address4") as! String
                    let Address5 = document.get("Address5") as! String

                    let stone = Stone(name: Name, description: Description, Address1: Address1, Address2: Address2, Address3: Address3, Address4: Address4, Address5: Address5)
                    self.savedStonesArray.append(stone)
                    self.tableView.reloadData()
                }
            }
        }
    }
}

    
    
    

    
    
    



extension AddressManagementViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // later, read data from FireStore
        let testCount = savedStonesArray.count
        
        return testCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let stone = savedStonesArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "My Address Cell", for: indexPath) as! MyAddressCell
        
        
        
        cell.setCellElements(name: stone.name, Address1: stone.Address1, Address2: stone.Address2, Address3: stone.Address3, Address4: stone.Address4, Address5: stone.Address5, image: "izu-stone")
        
        
        
        
        //cell.setCellElements(name: "Place \(indexPath.row)", address: "123-4567 Down the road", lastvisited: "Last Visited: 4/11 2020", image: "izu-stone")
        
        return cell
        
    }
    
    // - Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        //self.selectedIndex = indexPath.row
        
        // Get the selected stone data to send it through segue.
        // SelectedStone[0] will be passed through the segue,
        // in prepare segue method.
        let newStone = Stone(
            name: self.savedStonesArray[indexPath.row].name,
            description: self.savedStonesArray[indexPath.row].description,
            Address1: self.savedStonesArray[indexPath.row].Address1,
            Address2: self.savedStonesArray[indexPath.row].Address2,
            Address3: self.savedStonesArray[indexPath.row].Address3,
            Address4: self.savedStonesArray[indexPath.row].Address4,
            Address5: self.savedStonesArray[indexPath.row].Address5)
        
        
        
        
        self.selectedStone = newStone
        //self.selectedStone.append(newStone)
        
//        self.selectedStone[0].name = self.savedStonesArray[indexPath.row].name
//        self.selectedStone[0].description = self.savedStonesArray[indexPath.row].description
//        self.selectedStone[0].郵便番号 = self.savedStonesArray[indexPath.row].郵便番号
//        self.selectedStone[0].都道府県 = self.savedStonesArray[indexPath.row].都道府県
//        self.selectedStone[0].市区町村 = self.savedStonesArray[indexPath.row].市区町村
//        self.selectedStone[0].番地 = self.savedStonesArray[indexPath.row].番地
//        self.selectedStone[0].other = self.savedStonesArray[indexPath.row].other
        
        
        
        
        //print("selected stone loaded", selectedStone[0])
        
        performSegue(withIdentifier: "Edit Saved Stone Segue", sender: Any?.self)

    }
    
    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Edit Saved Stone Segue" {
            
            let vc = segue.destination as! EditSavedStoneViewController

            vc.stoneData = selectedStone
            
        }
        
        
    }
    
    
    
    // MARK: - Row Heights
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return 225.0
//        }
        
        return 185.0
    }
        
    
    
    
}
