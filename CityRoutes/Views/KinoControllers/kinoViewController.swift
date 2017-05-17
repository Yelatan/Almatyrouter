//
//  kinoViewController.swift
//  sideBarMenuNav
//
//  Created by Bakbergen on 22.04.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import UIKit
import SDWebImage

class kinoViewController: UIViewController, iCarouselDataSource, iCarouselDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var menuButton: UIBarButtonItem!
    var imageArray : NSMutableArray = NSMutableArray()
    var movieimageurl : NSMutableArray = NSMutableArray()
    var movieimagearray = [AnyObject]()
    var movieDict = [Int: String]()
    var viewui = UIView()
    var movieIDArray = [Int]()
    var imgstring = ""
    var photourl : [String] = []
    @IBOutlet var DisplayView: iCarousel!
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBarHidden = true
        self.navigationController?.hidesBarsOnSwipe = true

                self.navigationController?.navigationBar.barTintColor=UIColor.darkGrayColor()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackOpaque

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
        imageArray = ["http://www.kino.kz/archive/The_Angry_Birds_Movie/MoviePicture2.jpg"]
        
        self.loadData()
        DisplayView.type = iCarouselType.Linear
//        DisplayView.reloadData()
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if(option == iCarouselOption.Wrap) {
            return 1;
        }
        return value;
    }
    
    func loadData(){
        let url = NSURL(string: "http://ws.kino.kz/movies.data?k=AR78UK9Q&city=2&day=0")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
            (data, response, error) in dispatch_async(dispatch_get_main_queue(), {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                    if let posturls = json["data"] as? [[String: AnyObject]] {
                        for urldata in posturls{
                            let photojson : AnyObject? = urldata["big_poster"] as? String
                            let movieid = urldata["id"] as? Int
                            self.movieIDArray.append(movieid!)
                            self.photourl.append(photojson as! String)
                        }
                            print(self.photourl)
                            print("photourl")
                            self.DisplayView.reloadData()
                            self.DisplayView.currentItemIndex = self.photourl.count/2;
                        
                    }
                } catch {
                    print("error serializing JSON: \(error)")
                }
            })
        }
        task.resume()
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView{
        var imageView :UIImageView!
        if view == nil {
            
            imageView = UIImageView(frame:CGRect(x:0, y: 0, width: 173, height: 173))
            //            imageView.image = UIImage(named: "1.png")
            imageView.contentMode = .ScaleToFill
            
            
        }else{
            imageView = view as! UIImageView            
        }
        
        let urlString = self.photourl[index];
        let url = NSURL(string: urlString)
        imageView.sd_setImageWithURL(url);
        imageView.layer.cornerRadius = 5
        imageView.layer.borderColor = UIColor.redColor().CGColor
        return imageView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return self.photourl.count;
        
    }
    
    
    func carousel(carousel: iCarousel, didSelectItemAtIndex index: Int) {
        var vc: MovieDetailViewController//DetailMovieController!
        vc = (self.storyboard?.instantiateViewControllerWithIdentifier("MovieDetailViewController")) as! MovieDetailViewController;
        vc.indexcinema = movieIDArray[index]
        vc.moviephotos = self.photourl
        vc.imagestr = self.photourl[index]
        
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    lazy var productLines: [kinoProductLine] = {
        return kinoProductLine.productLines()
    }()
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let productLine = productLines[section]
        return productLine.name
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return productLines.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let productline = productLines[section]
        return productline.products.count
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("kinocell", forIndexPath: indexPath) as! kinoTableViewCell
        
//        cell.layer.borderColor = UIColor.blueColor().CGColor
//        cell.layer.borderWidth = 5
        
        let productLine = productLines[indexPath.section]
        let product = productLine.products[indexPath.row]
        let pr = productLine.products[indexPath.row].imagestring
        
        cell.configureCellWith(product)
        let url = NSURL(string: pr)
        cell.productImageView.image = nil
        cell.productImageView.sd_setImageWithURL(url!); 
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPathselected = tableview.indexPathForSelectedRow!
        let productLine = productLines[indexPathselected.section]
        let productDetailVC = segue.destinationViewController as! kinoDetailViewController
        productDetailVC.product = productAtIndexPath(indexPathselected)
        productDetailVC.imgurlString = productAtIndexPath(indexPathselected).imagestring

        
        
    }
    func productAtIndexPath(indexPath: NSIndexPath) -> kinoProduct{
        let productLine = productLines[indexPath.section]
        return productLine.products[indexPath.row]
    }

}
