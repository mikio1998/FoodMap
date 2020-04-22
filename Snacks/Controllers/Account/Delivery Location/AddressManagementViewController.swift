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

    var selectedStone: Stone = Stone(name: "", description: "", 都道府県: "", 市区町村: "", 郵便番号: "", 番地: "", other: "")
    
    
    // Func that unwinds VC's to this VC.
    // To pass data: https://www.youtube.com/watch?v=ULd2v4mHyQ4
    @IBAction func unwindToAddressManagement(_ sender: UIStoryboardSegue) {}
        

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Hides unused cells.
        tableView.tableFooterView = UIView()
        firestoreToArray()
    }
    
    
    func firestoreToArray() {
        
        self.savedStonesArray.removeAll()
        
        let stonesRef = FireStoreReferenceManager.referenceForUserPublicData(uid: Auth.auth().currentUser!.uid).collection("stones")

        stonesRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let Name = document.get("name") as! String
                    let Description = document.get("description") as! String
                    let 都道府県 = document.get("都道府県") as! String
                    let 市区町村 = document.get("市区町村") as! String
                    let 郵便番号 = document.get("郵便番号") as! String
                    let 番地 = document.get("番地") as! String
                    let other = document.get("other") as! String

                    let stone = Stone(name: Name, description: Description, 都道府県: 都道府県, 市区町村: 市区町村, 郵便番号: 郵便番号, 番地: 番地, other: other)
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
        
        cell.setCellElements(name: stone.name, 郵便番号: stone.郵便番号, 都道府県: stone.都道府県, 市区町村: stone.市区町村, 番地: stone.番地, other: stone.other, image: "izu-stone")
        
        
        
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
            都道府県: self.savedStonesArray[indexPath.row].都道府県,
            市区町村: self.savedStonesArray[indexPath.row].市区町村,
            郵便番号: self.savedStonesArray[indexPath.row].郵便番号,
            番地: self.savedStonesArray[indexPath.row].番地,
            other: self.savedStonesArray[indexPath.row].other)
        
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
