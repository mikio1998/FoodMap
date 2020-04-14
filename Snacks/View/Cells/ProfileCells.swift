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

    var img = "mikionakataface"
    var name = "\(setUserInfoStruct.firstname) \(setUserInfoStruct.lastname)"
    
    
    // MARK: - Helpers
    
    func setCellNameFieldandImage() {
        
        CellNameField.text = "user name"
        
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


class ProfileDescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CellTextField: UITextField!
    
    func setCellTextFieldPlaceholder() {
        
        // Later, get description from database.
        
        CellTextField.placeholder = "Hello, my name is..."
        //CellTextField.frame.height = 68.0
        
        
        
        
        
    }
    
    

}
