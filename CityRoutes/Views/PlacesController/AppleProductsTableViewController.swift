//
//  AppleProductsTableViewController.swift
//  Pretty Apple Table View
//
//  Created by Bakbergen on 05.04.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import UIKit

class AppleProductsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBAction func backbut(sender: AnyObject) {
        var vc: UIViewController//DetailMovieController!
        vc = (self.storyboard?.instantiateViewControllerWithIdentifier("AttractionViewController"))!// as! DetailMovieController;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    @IBOutlet var buttonMenu: UIBarButtonItem!
    @IBOutlet var tableview: UITableView!
    var numofsecc : Int = 0
    var index: Int = 0
    var productLines: [ProductLine] = []
    override func viewDidLoad() {
        super.viewDidLoad()
//        if self.revealViewController() != nil {
//            buttonMenu.target = self.revealViewController()
//            buttonMenu.action = "revealToggle:"
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        }
        productLines = [productLines1[index]]
    }
    
    lazy var productLines1: [ProductLine] = {
        
        return ProductLine.productLines()
    }()
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let productLine = productLines[section]
        return productLine.name
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let productline = productLines[section]
        
        
        
        return productline.products.count
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Show Detail", forIndexPath: indexPath) as! Product2TableViewCell
        
        let productLine = productLines[indexPath.section]
        let product = productLine.products[indexPath.row]
        self.title = productLine.name
        cell.configureCellWith(product)
        return cell
    
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPathselected = tableview.indexPathForSelectedRow!
        let productLine = productLines[indexPathselected.section]
        
        let productDetailVC = segue.destinationViewController as! ProductDetailViewController
        productDetailVC.product = productAtIndexPath(indexPathselected)
        

    }
    
    func productAtIndexPath(indexPath: NSIndexPath) -> Product{
            let productLine = productLines[indexPath.section]
        return productLine.products[indexPath.row]
    }
}