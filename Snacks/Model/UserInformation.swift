//
//  UserInformation.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/12/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation

struct setUserInfoStruct {
    
    static var username: String = ""
    static var email: String = ""
    static var firstname: String = ""
    static var lastname: String = ""
    static var uid: String = ""
    
    static func printItAll() {
        print(setUserInfoStruct.firstname, "YEHAHHHHH")
    }
    
    // - Assigns data to the static variables above.
    static func setUserInfo(uid: String) {
        // MARK: - Get ref to users public data collection
        let publicDocRef = FireStoreReferenceManager.referenceForUserPublicData(uid: uid)
        let privateDocRef = FireStoreReferenceManager.referenceForUserPrivateData(uid: uid)
        
//        var username: String = ""
//        var email: String = ""
//        var firstname: String = ""
//        var lastname: String = ""
//        var uid: String = ""
        
        // - Snapshot for Public Collection
        publicDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                // 1
                setUserInfoStruct.username = document.get("username") as? String ?? "User Name"
                //2
                //username = document.get("username") as? String ?? "User Name"
                
                print("Document data: \(username)")
            } else {
                print("Document does not exist")
            }
        }
        
        // - Snapshot for Private Collection
        privateDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                //1
                setUserInfoStruct.email = document.get("email") as? String ?? "email"
                setUserInfoStruct.firstname = document.get("firstname") as? String ?? "first"
                setUserInfoStruct.lastname = document.get("lastname") as? String ?? "last"
                setUserInfoStruct.uid = document.get("uid") as? String ?? "uid"
                
                //2
//                email = document.get("email") as? String ?? "email"
//                firstname = document.get("firstname") as? String ?? "first"
//                lastname = document.get("lastname") as? String ?? "last"
//                uid = document.get("uid") as? String ?? "uid"
                print("Document data: \(email) \(firstname) \(lastname) \(uid)")
            } else {
                print("Document does not exist")
            }
        }
        
    }

}




class userInfo {
    var uid : String
    var username : String
    var firstName: String
    var lastName: String
    var email: String

    
    init(uid: String, username: String, firstName: String, lastName: String, email: String) {
        self.uid = uid
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.email = email

    }

    
//    func setUser(uid: String, username: String, firstName: String, lastName: String, email: String) -> userInfo {
//        return userInfo(uid: uid, username: username, firstName: <#T##String#>, lastName: <#T##String#>, email: <#T##String#>)
//
//    }
}




