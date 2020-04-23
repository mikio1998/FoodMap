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


class ProfileDescriptionTableViewCell: UITableViewCell, UITextViewDelegate {
    

    
    
    
    @IBOutlet weak var cellTextView: UITextView!
    
    func setUpCellTextView() {
        cellTextView.delegate = self
        
        cellTextView.text = "自己紹介。。"
        cellTextView.textColor = UIColor.lightGray
        
        // Select textView as soon as view loads.
        cellTextView.becomeFirstResponder()
        cellTextView.selectedTextRange = cellTextView.textRange(from: cellTextView.beginningOfDocument, to: cellTextView.beginningOfDocument)
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//      // Combine the textView text and the replacement text to
//      // create the updated text string
//      let currentText: String = textView.text
//      let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
//
//      // If updated text view will be empty, add the placeholder
//      // and set the cursor to the beginning of the text view
//      if updatedText.isEmpty {
//          textView.text = "自己紹介。。"
//          textView.textColor = UIColor.lightGray
//
//          textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//      }
//      // Else if the text view's placeholder is showing and the
//      // length of the replacement string is greater than 0, set
//      // the text color to black then set its text to the
//      // replacement string
//       else if textView.textColor == UIColor.lightGray && !text.isEmpty {
//          textView.textColor = UIColor.black
//          textView.text = text
//      }
//      // For every other case, the text should change with the usual
//      // behavior...
//      else {
//          return true
//      }
//      // ...otherwise return false since the updates have already
//      // been made
//    return false
//    }
//
//
//
//
//    func textViewDidChangeSelection(_ textView: UITextView) {
//        if textView.textColor == UIColor.lightGray {
//            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//        }
//    }

    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Combine the current textView text and replacement text
        // to create the updated string.
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updatedText will be empty, add the placeholder
        // and set cursor to beginning of textView.
        if updatedText.isEmpty {
            textView.text = "自己紹介"
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
    
    
    func setCellLabelandHolder(index: Int) {
        // Minus 2 since there are two other cells before these cells.
        CellLabel.text = cellLabelsArray[index-2]
        CellTextField.placeholder = cellTextFieldHolders[index-2]
        
        
        
    }
    
    
    
}
