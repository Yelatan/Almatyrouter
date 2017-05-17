//
//  WeatherViewController.swift
//  sideBarMenuNav
//
//  Created by Bakbergen on 02.04.16.
//  Copyright © 2016 Bakbergen. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var lab1: UILabel!
    @IBOutlet var lab2: UILabel!
    @IBOutlet var lab3: UILabel!
    @IBOutlet var lab4: UILabel!
    @IBOutlet var lab5: UILabel!

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var datelabel: UILabel!
    @IBOutlet var buttonMenu: UIBarButtonItem!
    @IBOutlet var weatherdescription: UILabel!
    @IBOutlet var weathericon: UIImageView!
    @IBOutlet var cityname: UILabel!
    @IBOutlet var citytemplabel: UILabel!
    
    @IBOutlet var day5: UIImageView!
    @IBOutlet var day4: UIImageView!
    @IBOutlet var day3: UIImageView!
    @IBOutlet var day2: UIImageView!
    @IBOutlet var day1: UIImageView!
    
    @IBOutlet var date1: UILabel!
    
    @IBOutlet var day1labd: UILabel!
    @IBOutlet var day5labn: UILabel!
    @IBOutlet var day5labd: UILabel!
    @IBOutlet var day4labn: UILabel!
    @IBOutlet var day4labd: UILabel!
    @IBOutlet var day3labn: UILabel!
    @IBOutlet var day3labd: UILabel!
    @IBOutlet var day2labn: UILabel!
    @IBOutlet var day2labd: UILabel!
    @IBOutlet var day1labn: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        getweatherdata("http://api.openweathermap.org/data/2.5/forecast/daily?id=1526384&APPID=f08bebf53ff6bdd0cdeebed346af20ba")
//        getweatherdata("http://api.openweathermap.org/data/2.5/forecast?id=1526384&appid=f08bebf53ff6bdd0cdeebed346af20ba")
        
        getweatherdata("http://api.worldweatheronline.com/premium/v1/weather.ashx?key=6d8a9eb50774439899884113160905&q=Almaty&num_of_days=5&tp=24&format=json")
        imageView.animationImages = [
            UIImage(named: "1431060560ohlvy.jpg")!,
            UIImage(named: "almatyslide1.jpg")!,
            UIImage(named: "avtorazborka.kz-almaty-city.jpg")!,
            UIImage(named: "skyviewkz0001.jpg")!,
            UIImage(named: "skyviewkz0008.jpg")!
        ]
        imageView.animationDuration = 60
        imageView.startAnimating()
        if self.revealViewController() != nil {
            buttonMenu.target = self.revealViewController()
            buttonMenu.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func getweatherdata(urlString: String){
        let url = NSURL(string: urlString)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
            (data, response, error) in dispatch_async(dispatch_get_main_queue(), {
                
                self.setLabels(data!)
            })
        }
        task.resume()
    }
    
    func setLabels(weatherData: NSData){
        
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(NSCalendarUnit.Weekday, fromDate: NSDate())
        var weekDay = myComponents.weekday-1
        let dayofweek = ["","Пн","Вт","Ср","Чт","Пт","Сб","Вс"]
        print(weekDay)

        var dayarr = [Int]()
        for i in 1...8{
            dayarr.append(weekDay)
            weekDay += 1
            if weekDay>7{
                weekDay = 1
            }
        }
        lab1.text = dayofweek[dayarr[0]]
        lab2.text = dayofweek[dayarr[1]]
        lab3.text = dayofweek[dayarr[2]]
        lab4.text = dayofweek[dayarr[3]]
        lab5.text = dayofweek[dayarr[4]]
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "dd MMMM, yyyy"
        let todayDate = formatter.stringFromDate(NSDate())
        datelabel.text = todayDate
        print(todayDate)
        
        var temperatures = [String]()
        var ntemperatures = [String]()
        var icons = [String]()
        var descriptions = [String]()
   
//        func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
//            NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
//                completion(data: data, response: response, error: error)
//                }.resume()
//        }
        var codecount = 1
        var codstring = ""
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(weatherData, options: []) as! NSDictionary
            if let currenttemp = json["data"]!["current_condition"]!![0]["temp_C"] as? String{
                citytemplabel.text = currenttemp+"°C"
                
                }
            if let currentcode = json["data"]!["current_condition"]!![0]["weatherCode"] as? String{
                let strswift = currentcode
                let codedouble = (strswift as NSString).doubleValue
                if codedouble == 113.0 {
                    weatherdescription.text = "Солнечно"
                }
                if codedouble>=116.0 && codedouble <= 176.0 {
                    weatherdescription.text = "Пасмурно"
                }
                if codedouble>=179.0 && codedouble <= 284.0 {
                    weatherdescription.text = "Местами дождь"
                }
                if codedouble>=293.0 && codedouble <= 359.0 {
                    weatherdescription.text = "Сильный дождь"
                }
                if codedouble>=362.0 && codedouble <= 395.0 {
                    weatherdescription.text = "Cнег"
                }
            }
            if let temp = json["data"]!["weather"]! as? [[String: AnyObject]]{
                
                for temps in temp {
                    if let tempa = temps["hourly"]![0]["tempC"] as? String{
                        temperatures.append(tempa)
                        
                    }
                    if let ntempa = temps["mintempC"] as? String{
                        print(ntempa)
                        ntemperatures.append(ntempa)
                    }
                    
//                    if let dess = temps["hourly"]![0]["weatherDesc"]!![0]["value"] as? String{
//                        descriptions.append(dess)
//                    }
                    if let ico = temps["hourly"]![0]["weatherCode"] as? String{
                        icons.append(ico)
                        
                    }
                    
                };print(temperatures)
                print(descriptions)
                print(icons[0])
                //                citytemplabel.text = String(format: "%.f °C", temp-274)
            }
            else{
                
            }
            for i in 0...4{
                let daytemps = temperatures[i]
                let ntemps = ntemperatures[i]
                let ddouble = (daytemps as NSString).doubleValue
                let ndouble = (ntemps as NSString).doubleValue
                let strswift = icons[i]
                let codedouble = (strswift as NSString).doubleValue
                if codedouble == 113 {
                    codstring = "solnce.png"
                }
                if codedouble>=116 && codedouble <= 176 {
                    codstring = "alfacloud.png"
                }
                if codedouble>=179 && codedouble <= 284 {
                    codstring = "alfarain.png"
                }
                if codedouble>=293 && codedouble <= 359 {
                    codstring = "alfarainalfa.png"
                }
                if codedouble>=362 && codedouble <= 395 {
                    codstring = "alfasnow.png"
                }
                
                if i == 0 {
                    self.weathericon.image = UIImage(named: codstring)
                    day1.image = UIImage(named: codstring)
                    day2labn.text = String(format: "%.f", ddouble - ndouble)
                    day1labd.text = temperatures[i]
                }
                if i == 1 {
                    day2.image = try UIImage(named: codstring)
                    day2labd.text = temperatures[i]
                    day3labn.text = String(format: "%.f", ddouble - ndouble)
                }
                if i == 2 {
                    day3.image = try UIImage(named: codstring)
                    day3labd.text = temperatures[i]
                    day4labn.text = String(format: "%.f", ddouble - ndouble)
                }
                if i == 3 {
                    day4.image = try UIImage(named: codstring)
                    day4labd.text = temperatures[i]
                    day5labn.text = String(format: "%.f", ddouble - ndouble)
                }
                if i == 4 {
                    day5.image = try UIImage(named: codstring)
                }
            }
            cityname.text = "Алматы"
            let nday1 = citytemplabel.text
            let nddouble = (nday1! as NSString).doubleValue
            day1labn.text = String(format: "%.f", nddouble - 7)
            
        }catch let error as NSError {
            print("json error: \(error.localizedDescription)")
        }
        
        
    }

}
