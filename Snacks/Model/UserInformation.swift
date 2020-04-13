//
//  UserInformation.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/12/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation


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


struct setUserInfoStruct {

    
    static var username: String = ""
    static var email: String = ""
    static var firstname: String = ""
    static var lastname: String = "haha"
    
    
     //When UID is updated to the logging in User, changes HomeVC Struct property to true.
    static var uid: String = ""
//    {
//
//        didSet {
//            //userInfoObserver.didFinishWritingUserInfo = true
//            LogInViewController.userInfoObserver.didFinishWritingUserInfo = true
//
//
//
//        }
//    }
    
    
    
    

    
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

                setUserInfoStruct.username = document.get("username") as? String ?? "User Name"
                
                print("Document data: \(username)")
            } else {
                print("Document does not exist")
            }
        }
        
        // - Snapshot for Private Collection
        privateDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                setUserInfoClass.email = document.get("email") as? String ?? "email"
                setUserInfoClass.firstname = document.get("firstname") as? String ?? "first"
                setUserInfoClass.lastname = document.get("lastname") as? String ?? "last"
                setUserInfoClass.uid = document.get("uid") as? String ?? "uid"
                


                setUserInfoStruct.email = document.get("email") as? String ?? "email"
                setUserInfoStruct.firstname = document.get("firstname") as? String ?? "first"
                setUserInfoStruct.lastname = document.get("lastname") as? String ?? "last"
                setUserInfoStruct.uid = document.get("uid") as? String ?? "uid"

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
struct currentUser {
    
    static var uid : String = ""
    static var username : String = ""
    static var firstName: String = ""
    static var lastName: String = ""
    static var email: String = ""
    
    
    static var current = userInfo(uid: currentUser.uid, username: currentUser.username, firstName: currentUser.firstName, lastName: currentUser.lastName, email: currentUser.email)


}

    
