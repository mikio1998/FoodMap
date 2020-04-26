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
    @IBOutlet weak var Cell郵便番号: UILabel!
    @IBOutlet weak var Cell都道府県: UILabel!
    @IBOutlet weak var Cell市区町村: UILabel!
    @IBOutlet weak var Cell番地: UILabel!
    @IBOutlet weak var CellOther: UILabel!
    
    func setCellElements(
        name: String,
        郵便番号: String,
        都道府県: String,
        市区町村: String,
        番地: String,
        other: String,
        image: String) {
        
        CellName.text = name
        Cell郵便番号.text = 郵便番号
        Cell都道府県.text = 都道府県
        Cell市区町村.text = 市区町村
        Cell番地.text = 番地
        CellOther.text = other
        
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
    
    func setCellLabel(label: String) {
        cellLabel.text = label
    }
    
}

// MARK: - Google address search bar results cell
class SearchResultsCell: UITableViewCell {
    
}


