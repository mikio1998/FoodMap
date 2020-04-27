//
//  Test2ViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/26/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class Test2ViewController: UIViewController {


    @IBOutlet weak var MapView: GMSMapView!
    
    // Search selection data:
    // Place Name
    var selectionName: String = "Tokyo"
    // Latitude, longitude, initially at Tokyo.
    var selectionCoordinates: [Double] = [35.6762, 139.6503]
    
    
    // Views to present: (searchController, resultsViewController)
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?




    override func viewDidLoad() {
        super.viewDidLoad()
    
        // MARK: - Set up MapView
        MapView.delegate = self
        // GOOGLE MAPS SDK: Compass
        MapView.settings.compassButton = true
        // GOOGLE MAPS SDK: User Location
        MapView.isMyLocationEnabled = true
        MapView.settings.myLocationButton = true
        
        // Setting Initial map location.
        let location = GMSCameraPosition.camera(withLatitude: selectionCoordinates[0], longitude: selectionCoordinates[1], zoom: 15.0)
        MapView.camera = location
        
        
        // MARK: - Setting up the searchController and resultsViewController
        // Initialize resultsViewController.
        // Set resultsViewController delegate to self.
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
            
        // Initialize searchController.
        searchController = UISearchController(searchResultsController: resultsViewController)
        // searchController results will be updated
        // in resultsViewController.
        searchController?.searchResultsUpdater = resultsViewController
        
            
        // MARK: - Create subView for the searchController.
        let subView = UIView(frame: CGRect(x: 0, y: 88.0, width: 350.0, height: 45.0))
        
        // Add searchController.searchbar to the subView.
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false

        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // MARK: - Add map marker
//        let marker = GMSMarker()
//
//        let location = GMSCameraPosition.camera(withLatitude: selectionCoordinates[0], longitude: selectionCoordinates[1], zoom: 16.0)
//
//        marker.position = CLLocationCoordinate2D(latitude: selectionCoordinates[0], longitude: selectionCoordinates[1])
//        marker.title = selectionName
        
        
    }
}

extension Test2ViewController: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
        
        let marker = GMSMarker(position: self.MapView.camera.target)
        marker.title = self.selectionName
        marker.map = self.MapView
        
    }
    
}



// MARK: - Handle the user's selection.
extension Test2ViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                     didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        
        self.selectionName = place.name ?? "Location"
        self.selectionCoordinates.append(place.coordinate.latitude)
        self.selectionCoordinates.append(place.coordinate.latitude)
        
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        print("Place Coordinates: \(place.coordinate.latitude) \(place.coordinate.longitude)")
        print("vars", self.selectionName, self.selectionCoordinates)
        
//        let y = CLLocationDegrees(
//        let x = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: place.coordinate.latitude) ?? 35.6762, longitude: CLLocationDegrees(exactly: place.coordinate.longitude) ?? 139.6503)
        

        
        // Create Location with selection.
        let location = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0)
        // Animate MapView to the selected location.
        self.MapView.animate(to: location)
        

        
        }

    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didFailAutocompleteWithError error: Error){
            // TODO: handle the error.
            print("Error: ", error.localizedDescription)
    }


    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
