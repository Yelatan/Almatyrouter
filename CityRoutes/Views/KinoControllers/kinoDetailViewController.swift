//
//  ProductDetailViewController.swift
//  Pretty Apple Table View
//
//  Created by Bakbergen on 05.04.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import UIKit
import SwiftyJSON
class kinoDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var product : kinoProduct?
    var filmMap = [String: [KinoModel]]()
    var filmKeysArray = [String]()
    var indexcinema: Int = 0
    var imgurlString = ""
    @IBOutlet var tableView: UITableView!
    @IBOutlet var productdetaildescription: UILabel!
    @IBOutlet var productdetailtitle: UILabel!
    @IBOutlet var productimageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(indexcinema)
        print("indexcinema")
//        productimageView.image = product?.image
//        productdetailtitle.text = product?.title
//        productdetaildescription.text = product?.description
        indexcinema = (product?.idcinema)!
        var strindex = String(format: "%i", indexcinema)
        getweatherdata("http://ws.kino.kz/schedule_cinema.data?k=AR78UK9Q&city=2&day=0&cinema="+strindex)
        
//        self.loadData();
        
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
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(cinemaData, options: []) as! NSDictionary
            if let sessions = json["data"]!["times"] as? [[String: AnyObject]] {
                for dict in sessions {
                    
                    let filmID = (dict["m"]!["nameRus"] as? String)!
                    
                    var list = [KinoModel]();
                    
                    if ((filmMap[filmID]) != nil) {
                        list = (filmMap[filmID])!;
                    }
                    let timep = (dict["t"] as? String)!.componentsSeparatedByString(" ")
                    list.append(KinoModel(time: timep[1],
                        adult: String(format: "%.i", (dict["a"] as? Int)!),
                        child: String(format: "%.i", (dict["c"] as? Int)!),
                        stud: String(format: "%.i", (dict["s"] as? Int)!),
                        vip: String(format: "%.i", (dict["v"] as? Int)!)))
                    
                    filmMap[filmID] = list;
                }
                
            }
//            self.filmKeysArray = Array(filmMap.keys);
            self.filmKeysArray.append("")
            for key in self.filmMap.keys{
                self.filmKeysArray.append(key)
            }
            
            print(self.filmKeysArray)
            print("filmkeysarray")
            self.tableView.reloadData();
        } catch {
            print("error serializing JSON: \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let filmID = filmKeysArray[section]
//        let list = (filmMap[filmID])!;        
//        let film:KinoModel = list[0];
        return filmID + "\nЦена              Вз.              Дет.          Студ.       VIP"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.filmKeysArray.count;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else{
            let filmID = filmKeysArray[section]
            let list = (filmMap[filmID])!;
            return list.count
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
//            return 230
        }
        else{
            return 30
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let celldetail = tableView.dequeueReusableCellWithIdentifier("detailphotocell", forIndexPath: indexPath) as! kinodetailTableViewCell
            celldetail.cinemaimg.image = UIImage(named: "almatyslide1.jpg")
            let url = NSURL(string: imgurlString)
            celldetail.cinemaimg.image = nil
            celldetail.cinemaimg.sd_setImageWithURL(url!);
//            celldetail.imgurl(imgurlString)
            return celldetail
        }
        else{
            let celldetail = tableView.dequeueReusableCellWithIdentifier("detailcell", forIndexPath: indexPath) as! kinodetailTableViewCell
            let filmID = filmKeysArray[indexPath.section]
            let list = (filmMap[filmID])!;
            let film:KinoModel = list[indexPath.row];
            celldetail.configuredetailCellWith(film)
            return celldetail
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
            case 0:
                return 230
//            return UITableViewAutomaticDimension
        default: ()
        return 35        }
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
        if let imageCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? kinodetailTableViewCell {
            imageCell.scrollViewDidScroll(scrollView)
        }
    }
    
}



class kinodetailTableViewCell: UITableViewCell {
    var product : kinoProduct?
    @IBOutlet var bottomspace: NSLayoutConstraint!
    @IBOutlet var cinemaimg: UIImageView!
    @IBOutlet var topspace: NSLayoutConstraint!
    @IBOutlet var photoview: UIView!
    var imgstr = ""
    var imgurlArray = [String]()
    var urlindex = 0
    @IBOutlet var vip: UILabel!
    @IBOutlet var student: UILabel!
    @IBOutlet var child: UILabel!
    @IBOutlet var adult: UILabel!
    @IBOutlet var time: UILabel!
    
    func imgurl(imgurlString: String){
        let url = NSURL(string: imgurlString)
        cinemaimg.image = nil
        cinemaimg.sd_setImageWithURL(url!);
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 0 {
            // scrolling down
            photoview.clipsToBounds = true
            bottomspace?.constant = -scrollView.contentOffset.y / 2
            topspace?.constant = scrollView.contentOffset.y / 2
        } else {
            // scrolling up
            topspace?.constant = scrollView.contentOffset.y
            photoview.clipsToBounds = false
        }
    }
    func configuredetailCellWith(productdetail: KinoModel){
        time.text = productdetail.time
        adult.text = productdetail.adult
        child.text = productdetail.child
        student.text = productdetail.stud
        vip.text = productdetail.vip
        
    }
}

class KinoModel
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

