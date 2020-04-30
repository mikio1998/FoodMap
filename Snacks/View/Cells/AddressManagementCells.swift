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
    @IBOutlet weak var CellAddress1: UILabel!
    @IBOutlet weak var CellAddress2: UILabel!
    @IBOutlet weak var CellAddress3: UILabel!
    @IBOutlet weak var CellAddress4: UILabel!
    @IBOutlet weak var CellAddress5: UILabel!
    
    func setCellElements(
        name: String,
        Address1: String,
        Address2: String,
        Address3: String,
        Address4: String,
        Address5: String,
        image: String) {
        
        CellName.text = name
        CellAddress1.text = Address1
        CellAddress2.text = Address2
        CellAddress3.text = Address3
        CellAddress4.text = Address4
        CellAddress5.text = Address5
        
        CellImage.image = UIImage(named: image, in: Bundle(for: type(of: self)), compatibleWith: nil)
    }
}


// MARK: - Saved Stone Page
// MARK: - Edit Saved Stone screen
// Stone Images CollectionView Cell
class EditSavedStoneCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var CellImage: UIImageView!

    func setImage(image: String) {
        CellImage.image = UIImage(named: image, in: Bundle(for: type(of: self)), compatibleWith: nil)
        //CellImage.contentMode = UIView.ContentMode.scaleAspectFit
        //CellImage.contentMode = UICollectionViewCell.ContentMode.scaleAspectFit
        //CellImage.clipsToBounds = true
    }
}

class EditSavedStoneTextCell: UITableViewCell {
    
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    func setTextFieldAndLabel(labelText: String, fieldText: String) {
        self.cellLabel.text = labelText
        self.textField.text = fieldText
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
    @IBOutlet weak var errorLabel: UILabel!
    
    func setCellLabel(label: String, text: String) {
        cellLabel.text = label
        textField.text = text
    }
    
}

// MARK: - Google address search bar results cell
class SearchResultsCell: UITableViewCell {
    
}


