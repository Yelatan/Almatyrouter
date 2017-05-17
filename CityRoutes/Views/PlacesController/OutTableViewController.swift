//
//  OutTableViewController.swift
//  sideBarMenuNav
//
//  Created by Bakbergen on 28.03.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import UIKit

class OutTableViewController: UITableViewController{

    
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    var names = ["1.png","2.png", "3.png","4.png", "5.png"]
    var photos = [UIImage(named: "1.png"), UIImage(named: "2.png"), UIImage(named: "3.png"), UIImage(named: "4.png"), UIImage(named: "5.png")]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    
    func tableview(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableview(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
//        cell.tableviewlabel.text = names[indexPath.row]
//        cell.tableviewphoto.image = photos[indexPath.row]
//        cell.address.text = addresses[indexPath.row]
        
        return cell
    }
  
}
