//
//  ProductLine.swift
//  Pretty Apple Table View
//
//  Created by Bakbergen on 05.04.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import Foundation
import SwiftyJSON
class ProductLine
{
    
    var name: String
    var products: [Product]
    init(named: String, includeProduct: [Product])
    {
        name = named
        products = includeProduct
        
    }
    
    class func productLines() -> [ProductLine]
    {
        var objs = [self.iDevices(), self.mac(), self.software(), self.iPod(), self.iTunes(), self.kino()]
        
        return objs
        
    }
    
    private class func iDevices() -> ProductLine{
        
        var products = [Product]()
        var numofsections : Int
        do {
            let path: String = NSBundle.mainBundle().pathForResource("jsonjai", ofType: "json") as! String!
            let jsonData = NSData(contentsOfFile: path) as! NSData!
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)

            if let blogs = json["1"] as? [[String: AnyObject]] {
                for blog in blogs {
                    products.append(Product(titled: (blog["Title"] as? String)!, description: (blog["Description"] as? String)!, imageName: (blog["imageName"] as? String)!))
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
        return ProductLine(named: "Культурные объекты", includeProduct: products)
        
    }
    
    private class func mac() -> ProductLine{
        var products = [Product]()
        do {
            let path: String = NSBundle.mainBundle().pathForResource("jsonjai", ofType: "json") as! String!
            let jsonData = NSData(contentsOfFile: path) as! NSData!
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
            
            if let blogs = json["2"] as? [[String: AnyObject]] {
                for blog in blogs {
                    products.append(Product(titled: (blog["Title"] as? String)!, description: (blog["Description"] as? String)!, imageName: (blog["imageName"] as? String)!))
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
        return ProductLine(named: "Музей", includeProduct: products)
    }
    
    private class func software() -> ProductLine{
        var products = [Product]()
        do {
            let path: String = NSBundle.mainBundle().pathForResource("jsonjai", ofType: "json") as! String!
            let jsonData = NSData(contentsOfFile: path) as! NSData!
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
            
            if let blogs = json["3"] as? [[String: AnyObject]] {
                for blog in blogs {
                    products.append(Product(titled: (blog["Title"] as? String)!, description: (blog["Description"] as? String)!, imageName: (blog["imageName"] as? String)!))
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
        return ProductLine(named: "Парки и Зоопарки", includeProduct: products)
    }
    
    private class func iPod() -> ProductLine{
        var products = [Product]()
        do {
            let path: String = NSBundle.mainBundle().pathForResource("jsonjai", ofType: "json") as! String!
            let jsonData = NSData(contentsOfFile: path) as! NSData!
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
            
            if let blogs = json["4"] as? [[String: AnyObject]] {
                for blog in blogs {
                    products.append(Product(titled: (blog["Title"] as? String)!, description: (blog["Description"] as? String)!, imageName: (blog["imageName"] as? String)!))
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
        return ProductLine(named: "Покупки", includeProduct: products)
    }
    
    private class func iTunes() -> ProductLine{
        var products = [Product]()
        do {
            let path: String = NSBundle.mainBundle().pathForResource("jsonjai", ofType: "json") as! String!
            let jsonData = NSData(contentsOfFile: path) as! NSData!
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
            
            if let blogs = json["5"] as? [[String: AnyObject]] {
                for blog in blogs {
                    products.append(Product(titled: (blog["Title"] as? String)!, description: (blog["Description"] as? String)!, imageName: (blog["imageName"] as? String)!))
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
        return ProductLine(named: "Природа", includeProduct: products)
    }
    private class func kino() -> ProductLine{
        var products = [Product]()
        do {
            let path: String = NSBundle.mainBundle().pathForResource("jsonjai", ofType: "json") as! String!
            let jsonData = NSData(contentsOfFile: path) as! NSData!
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
            
            if let blogs = json["6"] as? [[String: AnyObject]] {
                for blog in blogs {
                    products.append(Product(titled: (blog["Title"] as? String)!, description: (blog["Description"] as? String)!, imageName: (blog["imageName"] as? String)!))
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
        return ProductLine(named: "Театр", includeProduct: products)
    }
    
}