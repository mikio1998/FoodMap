//
//  DeliveryMapViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/15/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class DeliveryMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // GOOGLE MAPS SDK: Compass
        mapView.settings.compassButton = true
        // GOOGLE MAPS SDK: User Location
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        
        
    }
    


}

extension DeliveryMapViewController: CLLocationManagerDelegate {
    // Called when User location changes.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
           print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        //lblLocation.text = "latitude = \(locValue.latitude), longitude = \(locValue.longitude)"
    }
}

