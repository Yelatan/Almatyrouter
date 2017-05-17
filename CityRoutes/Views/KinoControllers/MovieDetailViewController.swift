//
//  MovieDetailViewController.swift
//  CityRoutes
//
//  Created by Bakbergen on 11.05.16.
//  Copyright © 2016 AvSoft. All rights reserved.
//

import Foundation

import UIKit
import SDWebImage
import SwiftyJSON
class MovieDetailViewController: UIViewController{
    var product : kinoProduct?
    var movieMap = [Int: [MovieModel]]()
    var movieKeysArray = [Int]()
    var indexcinema = 0
    var cinemaDict = [Int: String]()
    var moviephotos = [String]()
    var movieimages = [UIImageView]()
    var imagestr = ""
    @IBOutlet var tableView: UITableView!
    @IBOutlet var movieimage: UIImageView!
    
    func pushNavigationItem(item: UINavigationItem, animated: Bool){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.hidesBarsOnSwipe = true
        
        self.navigationController?.navigationBar.barTintColor=UIColor.darkGrayColor()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackOpaque
//        self.navigationController?.navigationBarHidden = true

        var strindex = String(format: "%i", indexcinema)
        getweatherdata("http://ws.kino.kz/schedule_movie.data?k=AR78UK9Q&city=2&day=0&movie="+strindex)
    }
    
    func getweatherdata(urlString: String){
        let url = NSURL(string: urlString)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
            (data, response, error) in dispatch_async(dispatch_get_main_queue(), {
                
                self.loadData(data!)
            })
        }
        task.resume()
    }
    
    func loadData(cinemaData: NSData){
        let url = NSURL(string: "http://ws.kino.kz/cinemas.data?k=AR78UK9Q&city=2")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
            (data, response, error) in dispatch_async(dispatch_get_main_queue(), {
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                    if let sessions = json["data"] as? [[String: AnyObject]] {
                        for dict in sessions {
                            let namecinema = dict["name"] as? String
                            let idcinema = dict["id"] as? Int
                            self.cinemaDict[idcinema!] = namecinema
                        }
                    }
                    print(self.cinemaDict)
                    print("cinemaDict")
                    
                    //
                    let json2 = try NSJSONSerialization.JSONObjectWithData(cinemaData, options: []) as! NSDictionary
                    if let sessions = json2["data"]!["times"] as? [[String: AnyObject]] {
                        for dict in sessions {
                            
                            let filmName = (dict["ci"] as? Int)!
                            var list = [MovieModel]();
                            
                            if ((self.movieMap[filmName]) != nil) {
                                list = (self.movieMap[filmName])!;
                            }
                            let timep = (dict["t"] as? String)!.componentsSeparatedByString(" ")
                            list.append(MovieModel(time: timep[1],
                                adult: String(format: "%.i", (dict["a"] as? Int)!),
                                child: String(format: "%.i", (dict["c"] as? Int)!),
                                stud: String(format: "%.i", (dict["s"] as? Int)!),
                                vip: String(format: "%.i", (dict["v"] as? Int)!)))
                            
                            self.movieMap[filmName] = list;
                            
                        }
                        
                    }
                    //            self.movieKeysArray = Array(movieMap.keys);
                    self.movieKeysArray.append(0)
                    for key in self.movieMap.keys{
                        self.movieKeysArray.append(key)
                    }
                    print(self.movieKeysArray)
                    print("moviekeysarray")
                    self.tableView.reloadData();
//                    self.tableView.reloadData();
                } catch {
                    print("error serializing JSON: \(error)")
                }
            })
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var s = cinemaDict[movieKeysArray[section]]! + "\nЦена        Вз.           Дет.        Студ.       VIP"
            return s
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.movieKeysArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else{
            let movieID = movieKeysArray[section]
            let list = (movieMap[movieID])!;
            return list.count
        }
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        else{
            return 30
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let celldetail = tableView.dequeueReusableCellWithIdentifier("moviephoto", forIndexPath: indexPath) as! MovieDetailTableViewCell
            
            celldetail.imgurl(imagestr)

            return celldetail
        }
        else{
            let celldetail = tableView.dequeueReusableCellWithIdentifier("moviedetailcell", forIndexPath: indexPath) as! MovieDetailTableViewCell
            let movieID = movieKeysArray[indexPath.section]
            let list = (movieMap[movieID])!;
            
            let movie:MovieModel = list[indexPath.row];
            
            celldetail.configuredetailCellWith(movie)
            celldetail.backgroundColor = UIColor.clearColor()
            return celldetail
            
        }
        
    }
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 230
        default: ()
        return 35
        }
    }
    
     func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 10
        default: ()
        return 10
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if let imageCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? MovieDetailTableViewCell {
            imageCell.scrollViewDidScroll(scrollView)
        }
    }
}






class MovieDetailTableViewCell: UITableViewCell {
    @IBOutlet var bottomspace: NSLayoutConstraint!
    @IBOutlet var topspace: NSLayoutConstraint!
    
    @IBOutlet var movieimageview: UIView!
    @IBOutlet var movieimage: UIImageView!
    var umgurls = ""
    @IBOutlet var vip: UILabel!
    @IBOutlet var student: UILabel!
    @IBOutlet var child: UILabel!
    @IBOutlet var adult: UILabel!
    @IBOutlet var time: UILabel!

    @IBOutlet var movieCellImage: UIImageView!
    
    func imgurl(photourl: String){
        self.backgroundColor = UIColor.clearColor()
                            let url = NSURL(string: photourl)
                            movieimage.image = nil
                            movieimage.sd_setImageWithURL(url!)
                let min = CGFloat(-15.0)
                let max = CGFloat(15.0)
        
                let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
                xMotion.minimumRelativeValue = min
                xMotion.maximumRelativeValue = max
                let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongHorizontalAxis)
                yMotion.minimumRelativeValue = min
                yMotion.maximumRelativeValue = max
        
        
        
                let motionEffectGroup = UIMotionEffectGroup()
                motionEffectGroup.motionEffects = [xMotion, yMotion]
                movieimage.addMotionEffect(motionEffectGroup)
        
    }
    func configuredetailCellWith(productdetail: MovieModel){
        time.text = productdetail.time
        adult.text = productdetail.adult
        child.text = productdetail.child
        student.text = productdetail.stud
        vip.text = productdetail.vip
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 0 {
            // scrolling down
            movieimageview.clipsToBounds = true
            bottomspace?.constant = -scrollView.contentOffset.y / 2
            topspace?.constant = scrollView.contentOffset.y / 2
        } else {
            // scrolling up
            topspace?.constant = scrollView.contentOffset.y
            movieimageview.clipsToBounds = false

        }
    }
}

class MovieModel
{
    var time: String
    var adult: String
    var child: String
    var stud: String
    var vip: String
    init(time:String, adult:String, child: String, stud: String, vip: String)
    {
        self.time = time
        self.adult = adult
        self.child = child
        self.stud = stud
        self.vip = vip
        
    }
    
}

