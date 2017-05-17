//
//  OutViewController2.swift
//  sideBarMenuNav
//
//  Created by Bakbergen on 28.03.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import UIKit
import SwiftyJSON
class OutViewController2: UIViewController, iCarouselDataSource, iCarouselDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var dataArray : NSMutableArray = NSMutableArray()
    
    var imageArray : NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var tableView: UITableView!
    var names = ["caesar","starCinema", "Baikonur","4.png", "5.png"]
    var addresses = ["Абай","Орбита", "Спутник","4.png", "5.png"]
    var photos = [UIImage(named: "images.jpeg"), UIImage(named: "images-2.jpeg"), UIImage(named: "images-3.jpeg"), UIImage(named: "4.png"), UIImage(named: "5.png")]
    
    @IBOutlet var DisplayView: iCarousel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    //    @IBOutlet weak var DisplayView: iCarousel!
    
    func loadData(){
        // download from inet
        //        self.dataArray = json ... . .
        DisplayView.reloadData()
        //
        //
        var filmdict = [Int: [[AnyObject]]]()
        do {
            let path: String = NSBundle.mainBundle().pathForResource("checkhson", ofType: "json") as! String!
            let jsonData = NSData(contentsOfFile: path) as! NSData!
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
            var countdict = 0
            if let blogs = json["data"]!!["times"] as? [[String: AnyObject]] {
                for blog in blogs {
                    var booldict = true
                    if filmdict.isEmpty {
                        filmdict[(blog["m"]!["id"] as? Int)!] = [[(blog["t"] as? String)!, (blog["a"] as? Int)!, (blog["c"] as? Int)!, (blog["s"] as? Int)!, (blog["v"] as? Int)!]]
                    } else {
                        let dictKeys = filmdict.keys
                        for (key) in dictKeys {
                            if (blog["m"]!["id"] as? Int)! == key{
                                filmdict[(blog["m"]!["id"] as? Int)!]?.append([(blog["t"] as? String)!, (blog["a"] as? Int)!, (blog["c"] as? Int)!, (blog["s"] as? Int)!, (blog["v"] as? Int)!])
                                booldict = false
                                
                            }else{
                                
                            }
                            
                        }
                        if booldict{
                            filmdict[(blog["m"]!["id"] as? Int)!] = [[(blog["t"] as? String)!, (blog["a"] as? Int)!, (blog["c"] as? Int)!, (blog["s"] as? Int)!, (blog["v"] as? Int)!]]
                        }
                        
                    }
                }
                
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
        for (key, value) in filmdict {
            print("\(key)  \(value)")
        }
        //
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        imageArray = ["MoviePoster.jpg","MoviePoster-2.jpg", "MoviePoster-3.jpg","4.png", "5.png","6.png", "7.png","8.png"]
        DisplayView.type = iCarouselType.Cylinder
        DisplayView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    func carousel(carousel: iCarousel, didSelectItemAtIndex index: Int) {
    //        var vc: UIViewController//DetailMovieController!
    //        vc = (self.storyboard?.instantiateViewControllerWithIdentifier("DetailMovieController"))!// as! DetailMovieController;
    //        self.navigationController?.pushViewController(vc, animated: true);
    //
    //    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView{
        var s = 0
        var imageView :UIImageView!
        if view == nil {
            
            imageView = UIImageView(frame:CGRect(x:0, y: 0, width: 150, height: 150))
            //            imageView.image = UIImage(named: "1.png")
            imageView.contentMode = .ScaleAspectFit
            s = index
        }else{
            imageView = view as! UIImageView
            
        }
        imageView.image = UIImage(named: "\(imageArray.objectAtIndex(index))")
        //self.view1.clipsToBounds = true
        return imageView
        
        
    }
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return dataArray.count
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        
        //        let data:NSDictionary = self.dataArray[indexPath.row] as! NSDictionary;
        
        //        var imageUrl:String = data["bigPoster"] as! String
        //        if imageUrl == null {
        //            imageUrl = data["poster"] as! String
        //        }
        
        
        //        cell.photo.image = photos[indexPath.row]
        //        var name:String = data["title"] as! String
        
        cell.name.text = names[indexPath.row]
        cell.address.text = addresses[indexPath.row]
        
        return cell
    }
    
}

