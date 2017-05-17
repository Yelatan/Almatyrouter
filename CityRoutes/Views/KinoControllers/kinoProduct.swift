//
//  Product.swift
//  Pretty Apple Table View
//
//  Created by Bakbergen on 05.04.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import Foundation
import UIKit


class kinoProduct
{
    var title: String
    var description: String
    var image: UIImage
    var rating: ProductRating
    var imagestring: String
    var idcinema: Int
    init(idcinema: Int, titled:String, description:String, imageName: String)
    {
        self.title = titled
        self.description = description
        self.idcinema = idcinema
//        if let img = UIImage(named: imageName){
//            image = img
//        }else{
//            image = UIImage(named: "01d.png")!
//        }
        rating = .Unrated
        
        self.image = UIImage(named: "01d.png")!
        self.imagestring = imageName
       
        let url = NSURL(string: imageName)
        getDataFromUrl(url!) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
//                print(response?.suggestedFilename ?? "")
                let theimage = UIImage(data: data)
                self.image = theimage!
                
            }
        }
    }
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
}