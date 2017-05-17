//
//  ProductDetailViewController.swift
//  Pretty Apple Table View
//
//  Created by Bakbergen on 05.04.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    var product : Product?
    
    @IBOutlet var productdetailtext: UITextView!
    @IBOutlet var productdetaildescription: UILabel!
    @IBOutlet var productdetailtitle: UILabel!
    @IBOutlet var productimageView: UIImageView!
//    @IBOutlet var productdetaildescription: UILabel!
//    @IBOutlet var productdetailtitle: UILabel!
//    @IBOutlet var productimageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productimageView.image = product?.image
//        productdetailtitle.text = product?.title
//        productdetaildescription.text = product?.description
        productdetailtext.text = product?.description
        productimageView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
