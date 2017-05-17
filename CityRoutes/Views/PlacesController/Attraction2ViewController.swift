//
//  Attraction2ViewController.swift
//  sideBarMenuNav
//
//  Created by Bakbergen on 30.03.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import UIKit
import SwiftyJSON
class Attraction2ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
   
//    @IBOutlet var buttonMenu: UIBarButtonItem!
    @IBOutlet var buttonMenu: UIBarButtonItem!
    @IBOutlet var tableview: UITableView!
    
    
    var NumberOfRows = 0
    
    var DescriptionArray = [String]()
    var TitleArray = [String]()
    var photos = [UIImage(named: "BaluanSholak.png"), UIImage(named: "kurmangazy.png"),UIImage(named: "dvorec.png"), UIImage(named: "circus.png"),UIImage(named: "worldclass.png"), UIImage(named: "Rakhat Fitness.jpg"),UIImage(named: "fitness.jpg"), UIImage(named: "Дворец школьников.jpg"),UIImage(named: "Жамбыла.jpg")]
    
//    var photos = [UIImage(named: "culture2.png"), UIImage(named: "museum1.jpg"), UIImage(named: "parks1.png"), UIImage(named: "purchase1.png"), UIImage(named: "nature1.png"), UIImage(named: "theatr1.png")]
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        if self.revealViewController() != nil {
            buttonMenu.target = self.revealViewController()
            buttonMenu.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseJSON(){
        let path: String = NSBundle.mainBundle().pathForResource("jsonFile", ofType: "json") as! String!
        let jsonData = NSData(contentsOfFile: path) as! NSData!
        let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        //        var Name = readableJSON["People","Person1","Name"]
        NumberOfRows = readableJSON["Культурные объекты"].count
        NSLog("%.f", NumberOfRows)
//        let Title = readableJSON["Достопримечательность"]["Культурные объекты1"]["Title"].string as String!
//        let Description = readableJSON["Достопримечательность"]["Культурные объекты1"]["Description"].string as String!
//
//        TitleArray.append(Title)
//        DescriptionArray.append(Description)
                for i in 1...9{
                    var Countdes = "Культурные объекты"
                    Countdes += "\(i)"
                    let Title = readableJSON["Достопримечательность"][Countdes]["Title"].string as String!
                    let Description = readableJSON["Достопримечательность"][Countdes]["Description"].string as String!
        
                    TitleArray.append(Title)
                    DescriptionArray.append(Description)
                }
        
           }
    lazy var productLines: [ProductLine] = {
        
        return ProductLine.productLines()
    }()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        func numofsection() -> Int{
            return section
        }
        return 9
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableview.dequeueReusableCellWithIdentifier("attraction2cell", forIndexPath: indexPath) as! Attraction2Cell
        if DescriptionArray.count != 0 {
            cell.attraction2title.text = TitleArray[indexPath.row]
            cell.attraction2photo.image = photos[indexPath.row]
            cell.attraction2textview?.text = DescriptionArray[indexPath.row]
        }
        return cell
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPathselected = tableview.indexPathForSelectedRow!
        let productLine = productLines[indexPathselected.section]
   
        let productDetailVC = segue.destinationViewController as! AppleProductsTableViewController
        
        
        
        
        
    }
    func productAtIndexPath(indexPath: NSIndexPath) -> Product{
        let productLine = productLines[indexPath.section]
        
        NumberOfRows = indexPath.section
        func numofsectant() -> Int{
            return indexPath.row
        }
        return productLine.products[indexPath.row]
    }
    
}
