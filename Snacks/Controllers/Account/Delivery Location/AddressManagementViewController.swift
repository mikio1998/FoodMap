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
        
        let stonesRef = FireStoreReferenceManager.referenceForUserPublicData(uid: Auth.auth().currentUser!.uid).collection("stones")
            
            // MARK: TODO: Fix snapshot listener
            // MARK: It's adding duplicate.
            // Solution: Use snapshot diff. Just append the diff to the array.
            
            stonesRef.addSnapshotListener { querySnapshot, err in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(err!)")
                    return
                }
                
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        print("Stone: \(diff.document.data())")
                        
                        //var addedData: [Product] = diff.document.data().values
                        
                        
                        
                        let Name = diff.document.get("name") as! String
                        print(Name, "NAME")
                        let Description = diff.document.get("description") as! String
                        print(Description, "NAME")
                        let 都道府県 = diff.document.get("都道府県") as! String
                        let 市区町村 = diff.document.get("市区町村") as! String
                        let 郵便番号 = diff.document.get("郵便番号") as! String
                        let 番地 = diff.document.get("番地") as! String
                        let other = diff.document.get("other") as! String
                        
                        let stone = Stone(name: Name, description: Description, 都道府県: 都道府県, 市区町村: 市区町村, 郵便番号: 郵便番号, 番地: 番地, other: other)
                        
                        self.savedStonesArray.append(stone)

                        self.tableView.reloadData()
                    }
                    print(self.savedStonesArray, "saved stones")
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
        
        
        cell.setCellElements(name: stone.name, address: stone.都道府県, lastvisited: "na", image: "izu-stone")
        
        //cell.setCellElements(name: "Place \(indexPath.row)", address: "123-4567 Down the road", lastvisited: "Last Visited: 4/11 2020", image: "izu-stone")
        
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
