//
//  AfishaViewController.swift
//  CityRoutes
//
//  Created by Bakbergen on 18.05.16.
//  Copyright © 2016 AvSoft. All rights reserved.
//

import Foundation
import UIKit

class AfishaModel:NSObject{
    var title:String = "";
    var imagaUrl:String = "";
}

class AfishaViewController: UIViewController, FBSDKLoginButtonDelegate, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet var davaisxodimView: UIView!

    @IBOutlet var titleView: UIView!
    @IBOutlet var afishatableview: UITableView!
    @IBOutlet var Buttonmenu: UIBarButtonItem!
    var fbmessagearray = [AnyObject]()
     var viewWait = UIView()
    var tableData = [AfishaModel]()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor=UIColor(red: 44, green: 139, blue: 191, alpha: 1)
        viewWait = UIView(frame: CGRect(x: 20, y: 20, width: 200, height: 200))
        viewWait.backgroundColor = UIColor.redColor()
        let wait = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        wait.color = UIColor.whiteColor()
        wait.hidesWhenStopped = false
        wait.startAnimating()
        viewWait.addSubview(wait)
//        davaisxodimView.addSubview(viewWait)
        
        if self.revealViewController() != nil {
            Buttonmenu.target = self.revealViewController()
            Buttonmenu.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        if let token = FBSDKAccessToken.currentAccessToken(){
            fetchProfile()
        }
        if(FBSDKAccessToken.currentAccessToken() == nil){
            print("User is not log in")
        }
        else{
            print("User is log in")
        }
        self.loadData()
//        wait.stopAnimating()
//        wait.removeFromSuperview()
    }
    
    func loadData(){
        let parameters2 = ["fields":"posts.limit(20)","access_token":"243771869316986|BewC7WEgIC3LajOeb7zngS7WYCw"]
        FBSDKGraphRequest(graphPath: "258346474300490", parameters: parameters2, HTTPMethod:"GET").startWithCompletionHandler {(connection, result, error) -> Void in
            
            if error != nil{
                print(error)
                return
            }
            let posts2:[String:AnyObject] = (result["posts"] as? [String:AnyObject])!;
            let data2:[AnyObject] = (posts2["data"] as? [AnyObject]!)!;
            
            for m_data in data2 {
                
                let item = AfishaModel();
                
                let dict = m_data as? NSDictionary
                let afishaTitle = (dict!["message"] as? String)!.componentsSeparatedByString("\n")
                let title = (afishaTitle[0] as? String);
                
//                self.titlearray.append()
                let fbid = (dict!["id"] as? String)!
                let parameters3 = ["fields":"full_picture","access_token":"243771869316986|BewC7WEgIC3LajOeb7zngS7WYCw"]
                                
                FBSDKGraphRequest(graphPath: fbid, parameters: parameters3, HTTPMethod:"GET").startWithCompletionHandler {(connection, result, error) -> Void in
                    let fbpicture = result["full_picture"] as? String
                    
                    item.title = title!;
                    item.imagaUrl = fbpicture!;
                    
                    self.tableData.append(item)
                    self.afishatableview.reloadData()
                }
            }
            self.afishatableview.reloadData()
        }
    }
    
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        print("Complete login")
        fetchProfile()
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    func fetchProfile(){
        print("fetch profile")
     print(self.fbmessagearray)
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.tableData.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.afishatableview.dequeueReusableCellWithIdentifier("afishacell", forIndexPath: indexPath) as! AfishaTableViewCell

        let item = self.tableData[indexPath.row];
        let url = NSURL(string: item.imagaUrl)
        cell.productImageView.image = nil
        cell.productImageView.sd_setImageWithURL(url!);
        cell.productTitleLabel.text = item.title
        
                return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPathselected = self.afishatableview.indexPathForSelectedRow!
        
        let detaildavaisxodim = segue.destinationViewController as! DetailDavaisxodim
        detaildavaisxodim.getindex = indexPathselected.row
        
        
    }
}
class AfishaTableViewCell: UITableViewCell {
    
    @IBOutlet var titleView: UIView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productTitleLabel: UILabel!
}



