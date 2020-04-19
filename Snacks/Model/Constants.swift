//
//  Constants.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/7/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import Firebase
import GoogleMaps


// MARK: - Keys
struct Keys {
    static let GMSAPIKey = "AIzaSyDZQev69ikkMinqOZ06BmIHGbSg_NKIXXo"
}


struct Constants {
    
    struct Storyboard {
        
        static let homeViewController = "TabBarVC"
        //static let homeViewController = "HomeVC"
        
    }
    
}


struct FireStoreReferenceManager {
    // Change to "prod" for production environment.
    static let environment = "dev"
    static let db = Firestore.firestore()
    
    // dev > dev > 
    static let root = db.collection(environment).document(environment)
    
    // Returns publicData Document
    static func referenceForUserPublicData(uid: String) -> DocumentReference {
        return root
            .collection(FireBaseKeys.CollectionPath.users)
            .document(uid)
            .collection(FireBaseKeys.CollectionPath.publicData)
            
            
            
            .document(FireBaseKeys.CollectionPath.publicData)
    }
    
    // returns private Data document
    static func referenceForUserPrivateData(uid: String) -> DocumentReference {
        return root
            .collection(FireBaseKeys.CollectionPath.users)
            .document(uid)
            .collection(FireBaseKeys.CollectionPath.privateData)
            .document(FireBaseKeys.CollectionPath.privateData)
    }
    static func referenceForUserData(uid: String) -> DocumentReference {
        return root
            .collection(FireBaseKeys.CollectionPath.users)
            .document(uid)

    }
    
}


struct FireBaseKeys {
    struct CollectionPath {
        static let privateData = "privateData"
        static let publicData = "publicData"
        
        static let users = "users"
        
        let userUid = ""
        
    }
}
//都道府県
//市区町村
//郵便番号
//番地
//else
// (name: String, description: String, lastvisit: Date, 都道府県: String,  市区町村: String, 郵便番号: String, 番地: String, other: String)

// MARK: - Stone Class
class Stone {
    
    var name: String
    var description: String
    
    // Do later
    //var lastvisit: Date
    
    var 都道府県: String
    var 市区町村: String
    var 郵便番号: String
    var 番地: String
    var other: String
    
    init(name: String, description: String, 都道府県: String,  市区町村: String, 郵便番号: String, 番地: String, other: String) {
        
        self.name = name
        self.description = description
        //self.lastvisit = lastvisit
        
        self.都道府県 = 都道府県
        self.市区町村 = 市区町村
        self.郵便番号 = 郵便番号
        self.番地 = 番地
        self.other = other
        
        
    }
    
    
}





