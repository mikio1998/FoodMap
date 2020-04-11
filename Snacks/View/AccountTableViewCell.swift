//
//  AccountTableViewCell.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/11/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    var CellLabelsArray = ["Account Details", "My Delivery Locations", "Payment Methods"]

    @IBOutlet weak var CellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Helper
    func setCellLabel(index: Int) {
        CellLabel.text = CellLabelsArray[index]
    }


}
