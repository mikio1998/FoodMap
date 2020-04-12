//
//  Constants.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/7/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import Firebase



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
    
    static func referenceForUserPublicData(uid: String) -> DocumentReference {
        return root
            .collection(FireBaseKeys.CollectionPath.users)
            .document(uid)
            .collection(FireBaseKeys.CollectionPath.publicData)
            .document(FireBaseKeys.CollectionPath.publicData)
    }
    
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









