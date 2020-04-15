//
//  DeliveryMapViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/15/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit
import GoogleMaps

class DeliveryMapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        GMSServices.provideAPIKey("AIzaSyDZQev69ikkMinqOZ06BmIHGbSg_NKIXXo")
//        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: GMSCameraPosition)
//        self.view.addSubview(mapView)
//
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
