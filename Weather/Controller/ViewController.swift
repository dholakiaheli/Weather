//
//  ViewController.swift
//  Weather
//
//  Created by Heli Dholakia on 7/2/20.
//  Copyright © 2020 Heli Dholakia. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
let locationManager = CLLocationManager()
let APIKey = "bb15dc0d441f171472c0b3dd70b3fb7c"
    var longitude : Double = 0.0
    var latitude : Double = 0.0
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleGesture(_:)))
        
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        mapView.addGestureRecognizer(tap)
        
        checkLocationServices()
        mapView.delegate = self
    }
    
    @objc func handleGesture(_ gesture:UIGestureRecognizer){
        let touchPoint = gesture.location(in: mapView)
        let coordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        print(coordinates.latitude)
        print(coordinates.longitude)
        self.longitude = coordinates.longitude
        self.latitude = coordinates.latitude
        let storyboardObj = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboardObj.instantiateViewController(withIdentifier: "CurrentWeatherViewController") as! CurrentWeatherViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
 
    
    func checkLocationServices() {
      if CLLocationManager.locationServicesEnabled() {
        checkLocationAuthorization()
      } else {
        // Show alert letting the user know they have to turn this on.
      }
    }
    
    func checkLocationAuthorization() {
      switch CLLocationManager.authorizationStatus() {
      case .authorizedWhenInUse:
        break
//        mapView.showsUserLocation = true
       case .denied: // Show alert telling users how to turn on permissions
       break
      case .notDetermined:
        locationManager.requestWhenInUseAuthorization()
      case .restricted: // Show an alert letting them know what’s up
       break
      case .authorizedAlways:
       break
      }
}
}

extension ViewController:MKMapViewDelegate
{
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        mapView.showAnnotations([userLocation], animated: true)
    }

    
}
