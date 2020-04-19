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
    var savedStoneNames: [String] = []
    var savedStones: [Stone] = []
    
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
    
    
    // TODO: Read saved stones from FB
    func firestoreToArray() {
        
        // MARK: - Get all stone names.
        let publicDataDocument = FireStoreReferenceManager.referenceForUserPublicData(uid: Auth.auth().currentUser!.uid)
        
        publicDataDocument.getDocument { (documentSnapshot, err) in
             if let err = err {
                 print("Error getting documents: \(err)")
             } else {
                let names = documentSnapshot?.get("stone names") as! String
                let splitNames = names.components(separatedBy: " - ")
                
                for i in splitNames {
                    self.savedStoneNames.append(i)
                }
                // - Getting names finished. -
                print(self.savedStoneNames)

                //self.tableView.reloadData()
             
                }
        }
        
        print("for stoneName.....", self.savedStoneNames)
        // MARK: Get all Saved Stones (using the previous names)
        for stoneName in savedStoneNames {
            print(stoneName, "this")
            // Stone Collection
            let stoneCollection =
                FireStoreReferenceManager.root.collection(FireBaseKeys.CollectionPath.users)
                    .document(Auth.auth().currentUser!.uid)
                    .collection(FireBaseKeys.CollectionPath.publicData)
                    .document(FireBaseKeys.CollectionPath.publicData).collection(stoneName)
            
            
            
            // MARK:
            stoneCollection.getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    // Stone Address Doc
                    print("hello")
                    print(querySnapshot?.documents.count)
                    
                    
                    // Stone Description Doc
                    // Stone Images Doc
                    
                    
                    // For document in the query... check if product is already in Array.
//                    for document in querySnapshot!.documents {
//
//                        // Check if product is already in Array.
//                        let getName = document.get("name") as! String
//                        var notIn = true
//                        // Add to productArray if it completes every loop
//                        for product in self.savedStones {
//                            // if it's already in there, Break loop.
//                            if product.name == getName {
//                                notIn = false
//                                break
//                            } else {
//                                // else if it's not in there, continue looping.
//                                continue
//                            }
//                        }
//
//                        // If true, append to brandArray
//                        if notIn {
////                            //var new = document
////                            var doc = document.data() as [String:Any]
////                            doc.removeValue(forKey: "quantity")
//
////                            self.productArray.append(doc as! [String : String])
//
//                            self.savedStones.append()
//                        }
//                    }

                    // Dammn, I just spent a week solving this problem... one line.
                    self.tableView.reloadData()
        
                }
                
                
            }
            
            
            
            
//            stoneCollection.addSnapshotListener { (DocumentSnapshot, err) in
//                guard let snapshot = DocumentSnapshot else {
//                    print("Error fetching snapshots: \(err!)")
//                    return
//                }
     
//                snapshot.documentChanges.forEach { diff in
//                    if (diff.type == .added) {
//
//                        print("New stone: \(diff.document.data())")
//
//                        //var addedData: [Product] = diff.document.data().values
//                        let Description = diff.document.get("description") as! String
//                        let 都道府県 = diff.document.get("都道府県") as! String
//                        let 市区町村 = diff.document.get("市区町村") as! String
//                        let 郵便番号 = diff.document.get("郵便番号") as! String
//                        let 番地 = diff.document.get("番地") as! String
//                        let other = diff.document.get("other") as! String
//
//
//                        let stone = Stone(description: Description, 都道府県: 都道府県, 市区町村: 市区町村, 郵便番号: 郵便番号, 番地: 番地, other: other)
//
//                        self.savedStones.append(stone)
//
//                        self.tableView.reloadData()
//                    }
//
//
//                    // MARK: - Listen for changes.
//    //
//    //                if (diff.type == .modified) {
//    //                    print("Modified stone: \(diff.document.data())")
//    //
//    //                    let Name = diff.document.get("name") as! String
//    //                    let Quantity = diff.document.get("quantity") as! Int
//    //
//    //                    //print(self.thirdFloorArray, "array 33")
//    //                    if self.thirdFloorItems.contains(Name) { // Check product's floor
//    //                        // find it on thirdFLoorArray
//    //                        for element in self.thirdFloorArray {
//    //                            if element.name == Name {
//    //                                element.quantity = Quantity
//    //                                break
//    //                            }
//    //                         }
//    //                    } else {
//    //                        for element in self.otherFloorArray {
//    //                           if element.name == Name {
//    //                               element.quantity = Quantity
//    //                               break
//    //                           }
//    //                        }
//    //                    }
//    //                    self.tableView.reloadData()
//    //                }
//
//
//                    }
            
            
            
        }
        
 

 
            }

        }
        

    
    
    
    



extension AddressManagementViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // later, read data from FireStore
        let testCount = 2
        
        return testCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "My Address Cell", for: indexPath) as! MyAddressCell
        
        cell.setCellElements(name: "Person \(indexPath.row)", address: "123-4567 Down the road", lastvisited: "Last Visited: 4/11 2020", image: "izu-stone")
        
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
