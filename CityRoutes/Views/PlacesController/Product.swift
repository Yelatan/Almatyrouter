//
//  Product.swift
//  Pretty Apple Table View
//
//  Created by Bakbergen on 05.04.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import Foundation
import UIKit

public enum ProductRating
{
    case Unrated
    case Average
    case OK
    case Good
    case Brilliant
}

class Product
{
    var title: String
    var description: String
    var image: UIImage
    var rating: ProductRating
    init(titled:String, description:String, imageName: String)
    {
        self.title = titled
        self.description = description
        if let img = UIImage(named: imageName){
            image = img
        }else{
            image = UIImage(named: "01d.png")!
        }
        rating = .Unrated
    }
    
}