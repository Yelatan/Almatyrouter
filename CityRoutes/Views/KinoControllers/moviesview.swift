//
//  OutViewController2.swift
//  sideBarMenuNav
//
//  Created by Bakbergen on 28.03.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import UIKit

class moviesview: UIViewController, iCarouselDataSource, iCarouselDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var imageArray : NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var tableView: UITableView!
    var names = ["caesar","starCinema", "Baikonur","4.png", "5.png"]
    var addresses = ["Абай","Орбита", "Спутник","4.png", "5.png"]
    var photos = [UIImage(named: "images.jpeg"), UIImage(named: "images-2.jpeg"), UIImage(named: "images-3.jpeg"), UIImage(named: "4.png"), UIImage(named: "5.png")]
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var DisplayView: iCarousel!
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
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView{
        
        var imageView :UIImageView!
        if view == nil {
            
            imageView = UIImageView(frame:CGRect(x:0, y: 0, width: 150, height: 150))
            //            imageView.image = UIImage(named: "1.png")
            imageView.contentMode = .ScaleAspectFit
            
        }else{
            imageView = view as! UIImageView
            
        }
        imageView.image = UIImage(named: "\(imageArray.objectAtIndex(index))")
        return imageView
    }
    
    func carousel(carousel: iCarousel, didSelectItemAtIndex index: Int) {
        var vc: UIViewController//DetailMovieController!
        vc = (self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController"))!// as! DetailMovieController;
        self.navigationController?.pushViewController(vc, animated: true);
        
    }
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return imageArray.count
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        cell.photo.image = photos[indexPath.row]
        cell.name.text = names[indexPath.row]
        cell.address.text = addresses[indexPath.row]
        
        return cell
    }
    
}

