//
//  AttractionViewController.swift
//  sideBarMenuNav
//
//  Created by Bakbergen on 30.03.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import UIKit

class AttractionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var tableview: UITableView!
    var acount = 0
    var names = ["Культурные объекты", "Музей", "Парки и Зоопарки", "Покупки", "Природа", "Театр"]
    var photos = [UIImage(named: "culture2.png"), UIImage(named: "museum1.jpg"), UIImage(named: "parks1.png"), UIImage(named: "purchase1.png"), UIImage(named: "nature1.png"), UIImage(named: "theatr1.png")]
    var photos2 = [UIImage(named: "culture.png"), UIImage(named: "museum2.jpg"), UIImage(named: "park2.png"),UIImage(named: "shopping2.png"), UIImage(named: "nature2.png"), UIImage(named: "theatr2.png")]
    let myColors = [UIColor(red:74.0,green:7.0,blue:100.0,alpha:0.8), UIColor(red:96.0,green:16.0,blue:0.0,alpha:1.0), UIColor(red:12.0,green:0.0,blue:25.0,alpha:1.0), UIColor(red:12.0,green:30.0,blue:225.0,alpha:1.0), UIColor(red:212.0,green:20.0,blue:252.0,alpha:1.0), UIColor(red:123.0,green:230.0,blue:225.0,alpha:1.0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("tri")
        var cell = self.tableview.dequeueReusableCellWithIdentifier("cell", forIndexPath:  indexPath) as! AttractionCell
        cell.attractionphoto.image = photos[indexPath.row]
        cell.attractionphoto2.image = photos2[indexPath.row]
        cell.attractionlabel1.text = names[indexPath.row]
        cell.viewcolor.backgroundColor = myColors[indexPath.row]
       
        return cell
    }

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let identifier = segue.identifier {
//            switch identifier {
//                case "attraction2cell":
//                let attraction2VC = segue.destinationViewController as! Attraction2Cell
//                if let indexPath = self.tableview.indexPathForCell(sender as! UITableViewCell){
//                    attraction2VC.attraction2title.text = "Title tittle"
//                }
//            default: break
//            }
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPathselected = tableview.indexPathForSelectedRow!
        
        let appleProductsVC = segue.destinationViewController as! AppleProductsTableViewController
        appleProductsVC.index = indexPathselected.row
        
        
    }

}
