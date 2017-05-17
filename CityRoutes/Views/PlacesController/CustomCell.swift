//
//  CustomCell.swift
//  sideBarMenuNav
//
//  Created by Bakbergen on 29.03.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet var photo: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var name: UILabel!
    
    
   
    @IBOutlet var attractionphoto: UIImageView!
    @IBOutlet var attractionname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
