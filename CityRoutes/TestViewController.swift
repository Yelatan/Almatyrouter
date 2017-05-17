//
//  TestViewController.swift
//  CityRoutes
//
//  Created by Bakbergen on 9/27/16.
//  Copyright © 2016 AvSoft. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet var resultL: UILabel!
    @IBOutlet var task1T: UITextField!
    

    var gProgr = [1,3,9,27,81,243,729,2187]
    let q = 3.0
    let n = 8.0
    
    var aProg = [1,3,5,7,9,11,13,15]
    var d = 2
    
    
    @IBOutlet var result3L: UILabel!
    
    @IBOutlet var result2L: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var a = gProgr.count - 1
        print("n-ый член геомет.прогрес:")
//        print(gProgr[0] * (q << a))
        
        
        
        
        
        
    }

    @IBAction func nthtermGP(sender: AnyObject) {
        var text = task1T.text
        var a = Int(text!)
        var aD = Double(a!)
        
        var arrD = Double(gProgr[0])
        var resultGP = arrD * (pow(q, aD - 1))
        
        resultL.text = "\((resultGP))"
    }
    
    @IBAction func task2(sender: AnyObject) {
        
        var r2 = (2 * aProg[0] + ((aProg.count - 1) * d)) * aProg.count/2
        result2L.text = "\(r2)"
        
    }
    
    @IBAction func task3But(sender: AnyObject) {
        var b1 = Double(gProgr[0])
        var res3 = (b1 * (pow(q, n) - 1))/(q - 1)
        result3L.text = "\(res3)"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
