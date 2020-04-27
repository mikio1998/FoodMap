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

class DeliveryMapViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        // GOOGLE MAPS SDK: Compass
        mapView.settings.compassButton = true
        // GOOGLE MAPS SDK: User Location
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true

        
        
        let camera = GMSCameraPosition.camera(withLatitude: 35.724605, longitude: 139.771596, zoom: 18)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        view = mapView
        //let currentLocation = CLLocationCoordinate2DMake(35.724605, 139.771596)
        //let marker = GMSMarker(position: currentLocation)
        let marker = GMSMarker(position: camera.target)
        
        //marker.isDraggable = true
        marker.title = "Stone 1"
        marker.map = mapView
        
        func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
            marker.position = position.target
            print(marker.position)
        }
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

