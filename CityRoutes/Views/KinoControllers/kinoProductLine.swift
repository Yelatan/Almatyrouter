//
//  ProductLine.swift
//  Pretty Apple Table View
//
//  Created by Bakbergen on 05.04.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import Foundation
import SwiftyJSON
class kinoProductLine
{
    
    var name: String
    var products: [kinoProduct]
    
    init(named: String, includeProduct: [kinoProduct])
    {
        name = named
        products = includeProduct
    }
    
    class func productLines() -> [kinoProductLine]
    {
        return [self.iDevices()]
        //        return [self.kino()]
    }
    
    private class func iDevices() -> kinoProductLine{
        var products = [kinoProduct]()
        do {
            let path: String = NSBundle.mainBundle().pathForResource("json2jai", ofType: "json") as! String!
            let jsonData = NSData(contentsOfFile: path) as! NSData!
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
            
            if let blogs = json["data"] as? [[String: AnyObject]] {
                for blog in blogs {
                    products.append(kinoProduct(idcinema: (blog["id"] as? Int)!, titled: (blog["name"] as? String)!, description: (blog["address"] as? String)!, imageName: (blog["photo"] as? String)!))
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
        return kinoProductLine(named: "", includeProduct: products)
        
    }
    
    
    
}