//
//  AddressManagementCells.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/17/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit


// - MARK: My Addresses Cell
class MyAddressCell: UITableViewCell {
    // picture, address, name,
    // snack pref, exp date
    // last visited
    
    @IBOutlet weak var CellImage: UIImageView!
    @IBOutlet weak var CellName: UILabel!
    @IBOutlet weak var CellAddress: UILabel!
    @IBOutlet weak var CellLastVisited: UILabel!
    
    
    func setCellElements(name: String, address: String, lastvisited: String, image: String) {
        
        CellName.text = name
        CellAddress.text = address
        CellLastVisited.text = lastvisited
        
        CellImage.image = UIImage(named: image, in: Bundle(for: type(of: self)), compatibleWith: nil)
        
        
    }
    
}



// - MARK: New Address Cells
class GetAddressManuallyCell: UITableViewCell {
    
}

class GetAddressCurrentLocationCell: UITableViewCell {
    @IBOutlet weak var OpenMapButton: UIButton!
}


// MARK: Confirmation Images CollectionView Cell
class ConfirmAddressCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var CellImage: UIImageView!
    
    
    
    func setImage(image: String) {
        CellImage.image = UIImage(named: image, in: Bundle(for: type(of: self)), compatibleWith: nil)
        //CellImage.contentMode = UIView.ContentMode.scaleAspectFit
        //CellImage.contentMode = UICollectionViewCell.ContentMode.scaleAspectFit
        //CellImage.clipsToBounds = true
    }
    

    
    
    
}
