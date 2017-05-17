//
//  DetailDavaisxodim.swift
//  CityRoutes
//
//  Created by Bakbergen on 19.05.16.
//  Copyright © 2016 AvSoft. All rights reserved.
//

import Foundation
class DetailDavaisxodim: UIViewController{
    var getindex = 0
    var titlearray = [String]()
    var imagearray = [String]()
    @IBOutlet var detailimage: UIImageView!
    @IBOutlet var detailtext: UITextView!
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    override func viewDidLoad() {
        let parameters2 = ["fields":"posts.limit(10)","access_token":"243771869316986|BewC7WEgIC3LajOeb7zngS7WYCw"]
        //        cell.productTitleLabel.text = "title"
        FBSDKGraphRequest(graphPath: "258346474300490", parameters: parameters2, HTTPMethod:"GET").startWithCompletionHandler {(connection, result, error) -> Void in
            
            if error != nil{
                print(error)
                return
            }
            let posts2:[String:AnyObject] = (result["posts"] as? [String:AnyObject])!;
            let data2:[AnyObject] = (posts2["data"] as? [AnyObject]!)!;
            var titlearray = [String]()
            var imagearray = [String]()
            for m_data in data2 {
                let dict = m_data as? NSDictionary
                let afisha = (dict!["message"] as? String)!
                titlearray.append((afisha as? String)!)
                let fbid = (dict!["id"] as? String)!
                imagearray.append(fbid)
            }
            print(imagearray)
            
            let parameters3 = ["fields":"full_picture","access_token":"243771869316986|BewC7WEgIC3LajOeb7zngS7WYCw"]
            FBSDKGraphRequest(graphPath: imagearray[self.getindex], parameters: parameters3, HTTPMethod:"GET").startWithCompletionHandler {(connection, result, error) -> Void in
                let fbpicture = result["full_picture"] as? String
                //                                let imageurl = imagearray[indexPath.row]
                let url = NSURL(string: fbpicture!)
                self.getDataFromUrl(url!) { (data, response, error)  in
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        guard let data = data where error == nil else { return }
                        let theimage = UIImage(data: data)
                        self.detailimage.image = theimage!
//                        cell.productImageView.image = theimage!
                    }
                }
            }
            
            self.detailtext.text = titlearray[self.getindex]
        }
        
    }
    
}