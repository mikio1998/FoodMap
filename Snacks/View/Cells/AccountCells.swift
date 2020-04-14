//
//  AccountTableViewCell.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/11/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit

class AccountProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CellLabel: UILabel!
    @IBOutlet weak var CellImage: UIImageView!
    
    var username = "\(setUserInfoStruct.username)"

    var img = "mikionakataface"

    // MARK: - Helper
    func setCellLabelandImage() {
        CellLabel.text = username
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

class AccountMenuTableViewCell: UITableViewCell {
    
//    var CellLabelsArray = ["Mikio Nakata", "Account Details", "My Delivery Locations", "Payment Methods"]
    var CellLabelsArray = ["My Delivery Locations", "Payment Methods"]

    @IBOutlet weak var CellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Helper
    func setCellLabel(index: Int) {
        // Minus 1, since there is the Profile Cell at the beginning.
        CellLabel.text = CellLabelsArray[index-1]
    }


}
