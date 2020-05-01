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

// MARK: - Description TextView Cell
class AddressDescriptionTableViewCell: UITableViewCell, UITextViewDelegate {
    
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellTextView: UITextView!
    
    func setUpCellTextView(descriptionText: String) {
        cellTextView.delegate = self
        
        cellLabel.text = "場所の説明"
        
        // Set the TextCell text (Be it empty or not).
        cellTextView.text = descriptionText
        
        // If user has no Description,
        // set text as placeholder.
        if cellTextView.text.isEmpty {
            cellTextView.text = "山手線　上野駅西口。。\nお寺の左側、。。"
            cellTextView.textColor = UIColor.lightGray
        } else {
            //cellTextView.text = setUserInfoStruct.introduction
            cellTextView.textColor = UIColor.black
        }
        
        // Select textView as soon as view loads.
        cellTextView.becomeFirstResponder()
        cellTextView.selectedTextRange = cellTextView.textRange(from: cellTextView.beginningOfDocument, to: cellTextView.beginningOfDocument)
    }
    // MARK: - TextView placeholder
    // TextView has no placeholder property. So, programatcally added it.
    // https://stackoverflow.com/questions/27652227/how-can-i-add-placeholder-text-inside-of-a-uitextview-in-swift
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Combine the current textView text and replacement text
        // to create the updated string.
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updatedText will be empty, add the placeholder
        // and set cursor to beginning of textView.
        if updatedText.isEmpty {
            textView.text = "山手線　上野駅西口。。\nお寺の左側、。。"
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.endOfDocument)
        }
        
        // Else, if the textView's placeholder is showing,
        // and replacement string length is greater than zero,
        // set the textColor to black and set text to the replacement string.
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }
        // For every other case, the text should change
        // with the usual behavior...
        else {
            return true
        }
        // ... otherwise return false since the updates
        // have already been made.
        return false
    }
    // To prevent the user from changing the cursor position,
    // while the placeholder is visible.
    func textViewDidChangeSelection(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
    }
}



// MARK: - Text Field cells.
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

// MARK: Images Cell
class NewManualAddressScreenImagesCell: UITableViewCell {
    // Five Image Views
}

// MARK: Description TextView Cell
class NewManualAddressDescriptionTableViewCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellTextView: UITextView!
    
    func setUpCellTextView(descriptionText: String) {
        cellTextView.delegate = self
        cellLabel.text = "場所の説明"
        
        // Set the TextCell text (Be it empty or not).
        cellTextView.text = descriptionText
        
        // If user has no Description,
        // set text as placeholder.
        if cellTextView.text.isEmpty {
            cellTextView.text = "山手線　上野駅西口。。\nお寺の左側、。。"
            cellTextView.textColor = UIColor.lightGray
        } else {
            //cellTextView.text = setUserInfoStruct.introduction
            cellTextView.textColor = UIColor.black
        }
        
        // Select textView as soon as view loads.
        cellTextView.becomeFirstResponder()
        cellTextView.selectedTextRange = cellTextView.textRange(from: cellTextView.beginningOfDocument, to: cellTextView.beginningOfDocument)
    }
    // MARK: - TextView placeholder
    // TextView has no placeholder property. So, programatcally added it.
    // https://stackoverflow.com/questions/27652227/how-can-i-add-placeholder-text-inside-of-a-uitextview-in-swift
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Combine the current textView text and replacement text
        // to create the updated string.
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updatedText will be empty, add the placeholder
        // and set cursor to beginning of textView.
        if updatedText.isEmpty {
            textView.text = "山手線　上野駅西口。。\nお寺の左側、。。"
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.endOfDocument)
        }
        
        // Else, if the textView's placeholder is showing,
        // and replacement string length is greater than zero,
        // set the textColor to black and set text to the replacement string.
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }
        // For every other case, the text should change
        // with the usual behavior...
        else {
            return true
        }
        // ... otherwise return false since the updates
        // have already been made.
        return false
    }
    // To prevent the user from changing the cursor position,
    // while the placeholder is visible.
    func textViewDidChangeSelection(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("Ended editing Cell \(textView.tag)")
        
        
    }
    
    
}

//protocol TextFieldCellDelegate {
//    func textFieldText(cell: UITableViewCell, text: String)
//}
class NewManualAddressScreenTextFieldCell: UITableViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    func setCellLabel(label: String, text: String) {
        cellLabel.text = label
        textField.text = text
    }
}
//extension NewManualAddressScreenTextFieldCell: UITextFieldDelegate {
////    func textFieldDidBeginEditing(_ textField: UITextField) {
////        print("EDITING")
////    }
//
//    // Delegate method
//    // Called every time text is being updated.
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
//        delegate.textFieldText(self, text: result)
//    }
//}





// MARK: - Google address search bar results cell
class SearchResultsCell: UITableViewCell {
    
}


