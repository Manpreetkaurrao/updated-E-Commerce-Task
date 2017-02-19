//
//  ItemsInCartTableViewCell.swift
//  E-CommerceTask
//
//  Created by Sierra 4 on 18/02/17.
//  Copyright © 2017 codebrew2. All rights reserved.
//

import UIKit

class ItemsInCartTableViewCell: UITableViewCell {
    @IBOutlet var cartItems: UILabel!

    var productsInCart : String?
        {
        didSet
        {
            updateUI()
        }
    }
    fileprivate func updateUI()
    {
        cartItems.text = productsInCart
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
