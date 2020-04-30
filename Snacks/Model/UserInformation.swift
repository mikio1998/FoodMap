//
//  UserInformation.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/12/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import Firebase


class setUserInfoClass {
    static var username: String = ""
    static var email: String = ""
    static var firstname: String = ""
    static var lastname: String = "haha"
    
    static var uid: String = "" {
        
        didSet {
            userInfoObserver.didFinishWritingUserInfo = true
            
            
            print("done!")
            print(userInfoObserver.didFinishWritingUserInfo)
        }
    }
}
// MARK: - Current Users location coordinates
struct currentUserLocation {
    // Default set as Tokyo Station
    static var latitude: Double = 35.681708
    static var longitude: Double = 139.767053

}

struct setUserInfoStruct {
    static var username: String = ""
    static var email: String = ""
    static var firstname: String = ""
    static var lastname: String = ""
    static var phonenumber: String = ""
    static var introduction: String = ""
    static var password: String = "placeholder password"
    
     //When UID is updated to the logging in User, changes HomeVC Struct property to true.
    static var uid: String = ""

    
    static func printUserInfoToConsole() {
        print("Logged In:", firstname, lastname)
        //print("Username:", setUserInfoStruct.username)
        //print("First Name:", setUserInfoStruct.firstname)
        //print("First Name:", setUserInfoStruct.lastname)
        print("Email:", setUserInfoStruct.email)
        print("UID:", setUserInfoStruct.uid)
    }
    
    // - Assigns data to the static variables above.
    static func setUserInfo(uid: String) {
        // MARK: - Get ref to users public data collection
        let publicDocRef = FireStoreReferenceManager.referenceForUserPublicData(uid: uid)
        let privateDocRef = FireStoreReferenceManager.referenceForUserPrivateData(uid: uid)
        
        // - Snapshot for Public Collection
        publicDocRef.getDocument { (document, error) in
            if let document = document, document.exists {

            } else {
                print("Document does not exist")
            }
        }
        
        // - Snapshot for Private Collection
        privateDocRef.getDocument { (document, error) in
            if let document = document, document.exists {

                setUserInfoStruct.username = document.get("username") as? String ?? "username"
                
                setUserInfoStruct.email = document.get("email") as? String ?? "email"
                setUserInfoStruct.firstname = document.get("firstname") as? String ?? "first"
                setUserInfoStruct.lastname = document.get("lastname") as? String ?? "last"
                
                setUserInfoStruct.phonenumber = document.get("phone") as? String ?? "0"
                setUserInfoStruct.introduction = document.get("introduction") as? String ?? "Hello!"
                
                setUserInfoStruct.uid = document.get("uid") as? String ?? "uid"
                
                

                print("Document data: \(email) \(firstname) \(lastname) \(uid)")
                print("Document data: \(phonenumber), \(introduction)")
                print("Document data: \(username)")
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
}
struct currentUser {
    
    static var uid : String = ""
    static var username : String = ""
    static var firstName: String = ""
    static var lastName: String = ""
    static var email: String = ""
    
    
    static var current = userInfo(uid: currentUser.uid, username: currentUser.username, firstName: currentUser.firstName, lastName: currentUser.lastName, email: currentUser.email)
}

    
