import UIKit
import GoogleMaps

class ViewController: UIViewController{
    
    
    var mapTasks = MapTasks()
    var locationMarker: GMSMarker!
    
    var originMarker: GMSMarker!
    
    var destinationMarker: GMSMarker!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var bbut: UIBarButtonItem!
    var routePolyline: GMSPolyline!
    @IBOutlet weak var viewMap: GMSMapView!
    let locationManager = CLLocationManager()
    var didFindMyLocation = false
//    func requestFacebook() {
//        
//        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "258346474300490", parameters: ["fields": "posts", "access_token": "243771869316986|BewC7WEgIC3LajOeb7zngS7WYCw"])
//        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
//            
//            if ((error) != nil)
//            {
//                // Process error
//                print("Error: \(error)")
//            }
//            
//        })
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if self.revealViewController() != nil {
            bbut.target = self.revealViewController()
            bbut.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
//        let camera = GMSCameraPosition.cameraWithLatitude(43.304638,
//            longitude: 76.77649, zoom: 10)
//        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
//        mapView.myLocationEnabled = true
//        viewMap.camera = camera
//        
//        
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2DMake(43.304638, 76.776498)
//        marker.title = "Almaty sd sd sds ds ds"
//        marker.snippet = "Kazakhstan sdasd asd asd "
//        marker.map = viewMap
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

    }
    
    @IBAction func createRoute(sender: AnyObject) {
        let addressAlert = UIAlertController(title: "Create Route", message: "Connect locations with a route:", preferredStyle: UIAlertControllerStyle.Alert)
        
        addressAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Origin?"
        }
        
        addressAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Destination?"
        }
        
        
        let createRouteAction = UIAlertAction(title: "Create Route", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
//            let origin = (addressAlert.textFields![0] as! UITextField).text as! String
             let origin = "almaty, " + (addressAlert.textFields![0] as! UITextField).text! as String
//            let address = "almaty, " + (addressAlert.textFields![0] as! UITextField).text! as String
            
//            let destination = (addressAlert.textFields![1] as! UITextField).text as! String
             let destination = "almaty, " + (addressAlert.textFields![1] as! UITextField).text! as String
            
            self.mapTasks.getDirections(origin, destination: destination, waypoints: nil, travelMode: nil, completionHandler: { (status, success) -> Void in
                if success {
                    self.configureMapAndMarkersForRoute()
                    self.drawRoute()
                    self.displayRouteInfo()
                }
                else {
                    print(status)
                }
            })
        }
        
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        addressAlert.addAction(createRouteAction)
        addressAlert.addAction(closeAction)
        
        presentViewController(addressAlert, animated: true, completion: nil)
    }
    //----
    func configureMapAndMarkersForRoute() {
        viewMap.camera = GMSCameraPosition.cameraWithTarget(mapTasks.originCoordinate, zoom: 9.0)
        originMarker = GMSMarker(position: self.mapTasks.originCoordinate)
        originMarker.map = self.viewMap
        originMarker.icon = GMSMarker.markerImageWithColor(UIColor.greenColor())
        originMarker.title = self.mapTasks.originAddress
        
        destinationMarker = GMSMarker(position: self.mapTasks.destinationCoordinate)
        destinationMarker.map = self.viewMap
        destinationMarker.icon = GMSMarker.markerImageWithColor(UIColor.redColor())
        destinationMarker.title = self.mapTasks.destinationAddress    
    }
    //-- 
    func drawRoute() {
        let route = mapTasks.overviewPolyline["points"] as! String
        
        let path: GMSPath = GMSPath(fromEncodedPath: route)!
        routePolyline = GMSPolyline(path: path)
        routePolyline.map = viewMap
    }
    //--
    func displayRouteInfo() {
        lblInfo.text = mapTasks.totalDistance + "\n" + mapTasks.totalDuration
    }
    
    
    
   
    
    func setupLocationMarker(coordinate: CLLocationCoordinate2D) {
        if locationMarker != nil {
            locationMarker.map = nil
        }
        locationMarker = GMSMarker(position: coordinate)
        locationMarker.map = viewMap
        locationMarker.title = mapTasks.fetchedFormattedAddress
//        locationMarker.appearAnimation = kGMSMarkerAnimationPop
        locationMarker.opacity = 1
        locationMarker.icon = UIImage(named: "mar")
        locationMarker.flat = true
        locationMarker.snippet = "The best place on Almaty."
    }
    
    

    @IBAction func changeMapType(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "Map Types", message: "Select map type:", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let normalMapTypeAction = UIAlertAction(title: "Normal", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            
            self.viewMap.mapType = kGMSTypeNormal
        }
        
        let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.viewMap.mapType = kGMSTypeTerrain
        }
        
        let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.viewMap.mapType = kGMSTypeHybrid
        }
        
        let cancelAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(normalMapTypeAction)
        actionSheet.addAction(terrainMapTypeAction)
        actionSheet.addAction(hybridMapTypeAction)
        actionSheet.addAction(cancelAction)
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func findAddress(sender: AnyObject) {
        let addressAlert = UIAlertController(title: "Address Finder", message: "Type the address you want to find:", preferredStyle: UIAlertControllerStyle.Alert)
        
        addressAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Address?"
        }
        
        let findAction = UIAlertAction(title: "Find Address", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            let address = "almaty, " + (addressAlert.textFields![0] as! UITextField).text! as String
            
            self.mapTasks.geocodeAddress(address, withCompletionHandler: { (status, success) -> Void in
                if !success {
                    print(status)
                    
                    if status == "ZERO_RESULTS" {
                       self.showAlertWithMessage("The location could not be found.")
                        
                    }
                }
                else {
                    let coordinate = CLLocationCoordinate2D(latitude: self.mapTasks.fetchedAddressLatitude, longitude: self.mapTasks.fetchedAddressLongitude)
                    self.viewMap.camera = GMSCameraPosition.cameraWithTarget(coordinate, zoom: 14.0)
                    self.setupLocationMarker(coordinate)
                }
            })
            
        }
        
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        addressAlert.addAction(findAction)
        addressAlert.addAction(closeAction)
        
        presentViewController(addressAlert, animated: true, completion: nil)
    }
    
    func showAlertWithMessage(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        alertController.addAction(closeAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
            viewMap.myLocationEnabled = true
            viewMap.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            viewMap.camera = GMSCameraPosition(target: location.coordinate, zoom: 10, bearing: 0, viewingAngle: 0)
            
            locationManager.stopUpdatingLocation()
        }
        
    }
}


