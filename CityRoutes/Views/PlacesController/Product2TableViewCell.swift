//
//  Product2TableViewCell.swift
//  Pretty Apple Table View
//
//  Created by Bakbergen on 05.04.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import UIKit

class Product2TableViewCell: UITableViewCell {
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productDescriptionLabel: UILabel!
    @IBOutlet var productTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCellWith(product: Product){
        productImageView.image = product.image
        productDescriptionLabel.text = product.description
        productTitleLabel.text = product.title
        productImageView.clipsToBounds = true
    }
    

}
