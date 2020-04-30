//
//  AccountSettingsProfileCell.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/14/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit


class ProfileTableViewCell: UITableViewCell {
    
    // outlets
    @IBOutlet weak var CellImage: UIImageView!
    @IBOutlet weak var CellNameField: UITextField!

    var img = "usericon"
    var username = "\(setUserInfoStruct.username)"
    var firstname = "\(setUserInfoStruct.firstname)"
    var lastname = "\(setUserInfoStruct.lastname)"
    
    
    // MARK: - Helpers
    
    func setCellNameFieldandImage() {
        
        CellNameField.text = username
        
        CellImage.image = UIImage(named: img, in: Bundle(for: type(of: self)), compatibleWith: nil)

        makeRounded()
    }
    
    // - Makes UIImageView round.
    func makeRounded() {
        self.CellImage.layer.borderWidth = 1
        self.CellImage.layer.masksToBounds = false
        self.CellImage.layer.borderColor = UIColor.black.cgColor
        self.CellImage.layer.cornerRadius = self.CellImage.frame.height/2
        self.CellImage.clipsToBounds = true
    }

}
// MARK: - TextView Cell
// Profile Description TextView Cell.
class ProfileDescriptionTableViewCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var cellTextView: UITextView!
    
    func setUpCellTextView() {
        cellTextView.delegate = self
        
        // If user has no Introduction,
        // set text as placeholder.
        if setUserInfoStruct.introduction == "" {
            cellTextView.text = "自己紹介。。。"
            cellTextView.textColor = UIColor.lightGray
        } else {
            cellTextView.text = setUserInfoStruct.introduction
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
            textView.text = "自己紹介。。。"
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


class ProfileIdentityInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CellLabel: UILabel!
    
    @IBOutlet weak var CellTextField: UITextField!
    
    var cellLabelsArray = [
        "姓 (Last Name)",
        "名 (First Name)",
        "携帯電話番号 (Cell)",
        "メール (Email)",
        "パスワード (Password)"]
    var cellTextFieldHolders = [
        "Hawk",
        "Mike",
        "080-1234-5678",
        "snacks@mail.com",
        "password1"
    ]
    
    var setUserInfoStructVariables = [
        "lastname",
        "firstname",
        "phonenumber",
        "email",
        "password"
    ]
    
    
    func setCellLabelandHolder(index: Int) {
        // Minus 2 since there are two other cells before these cells.
        CellLabel.text = cellLabelsArray[index-2]
        CellTextField.placeholder = cellTextFieldHolders[index-2]
        
        switch index {
        case 2:
            CellTextField.text = setUserInfoStruct.lastname
        case 3:
            CellTextField.text = setUserInfoStruct.firstname
        case 4:
            CellTextField.text = setUserInfoStruct.phonenumber
        case 5:
            CellTextField.text = setUserInfoStruct.email
        case 6:
            CellTextField.text = setUserInfoStruct.password

        default:
            CellTextField.text = "Couldn't fetch."
        }
    }
}
