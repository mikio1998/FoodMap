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


// MARK: - Saved Stone Page
// Stone Images CollectionView Cell
class StoneCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var CellImage: UIImageView!

    func setImage(image: String) {
        CellImage.image = UIImage(named: image, in: Bundle(for: type(of: self)), compatibleWith: nil)
        //CellImage.contentMode = UIView.ContentMode.scaleAspectFit
        //CellImage.contentMode = UICollectionViewCell.ContentMode.scaleAspectFit
        //CellImage.clipsToBounds = true
    }
}



// MARK: - New Address Menu Cells
class GetAddressMenuManuallyCell: UITableViewCell {
    
}

class GetAddressMenuCurrentLocationCell: UITableViewCell {
    @IBOutlet weak var OpenMapButton: UIButton!
}




// MARK: - New Manual Address Screen
class NewManualAddressScreenImagesCell: UITableViewCell {
    // Five Image Views
    
}

class NewManualAddressScreenTextFieldCell: UITableViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    func setCellLabel(label: String) {
        cellLabel.text = label
    }
    
}
