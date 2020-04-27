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
    
    var mapMarker: GMSMarker?
    
    
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
    }
}



extension Test2ViewController: GMSMapViewDelegate {
    
    
    // when map animation is called.
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
        // Call, when user selects new location.
        // Remove the previous mapMarker from the map.
        // self.mapMarker?.map = nil

    }
    
    // didchange
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        self.mapMarker = GMSMarker(position: self.MapView.camera.target)
//        self.mapMarker?.title = self.selectionName
//
//    }
    
    
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
        
        
        // MARK: - Place Marker at selected Location.
        let coordinates = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        //let marker = GMSMarker(position: coordinates)
        //marker.title = place.name
        //marker.map = self.MapView
        
        self.mapMarker = GMSMarker(position: coordinates)
        self.mapMarker?.title = place.name
        self.mapMarker?.map = self.MapView
        
        
        // MARK: - Animate map to new Location.
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
