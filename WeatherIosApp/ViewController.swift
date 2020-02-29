//
//  ViewController.swift
//  WeatherIosApp
//
//  Created by Ahmed Hegazy on 2/28/20.
//  Copyright © 2020 Ahmed Hegazy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import CoreLocation




class ViewController: UIViewController , CLLocationManagerDelegate{
    
    @IBOutlet var labelCountry: UILabel!
    @IBOutlet var labelDay: UILabel!
    @IBOutlet var imageCondition: UIImageView!
    @IBOutlet var labelCondition: UILabel!
    @IBOutlet var labelTemp: UILabel!
    @IBOutlet var viewBackground: UIView!
    
    let gradientLayer = CAGradientLayer()
    let apiKey = "958b79f74fc722a728672ba728785e74"
    let locationManager = CLLocationManager()
    var activityIndicator: NVActivityIndicatorView! = nil
    var lat = 0.0
    var lon = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.viewBackground.layer.addSublayer(gradientLayer)
        
        
        createIndicatorView()
        checkLocationService()
        
        
        
        
        
    }
    
    func checkLocationService(){
        locationManager.requestWhenInUseAuthorization()
        //returned until you allow
        
        ///if allowed go there
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }else{
            
        }
        
    }
    
    func createIndicatorView(){
        let indicatorSize: CGFloat = 70
        let indicatorFrame = CGRect(x: (view.frame.width - indicatorSize)/2, y: (view.frame.height - indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20)
        activityIndicator.backgroundColor = UIColor.black
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        
        
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        AF.request(url).responseJSON { (responsJson) in
            
            
            debugPrint("Response : \(responsJson)")
            self.activityIndicator.stopAnimating()
            
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setBlueGradientBackground()
        //        setGrayGradientBackground()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    
    
    func setBlueGradientBackground(){
        
        let topColor = UIColor(displayP3Red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(displayP3Red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
        
        
    }
    
    func setGrayGradientBackground(){
        
        let topColor = UIColor(displayP3Red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(displayP3Red: 72.0/255.0, green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    
    
}

