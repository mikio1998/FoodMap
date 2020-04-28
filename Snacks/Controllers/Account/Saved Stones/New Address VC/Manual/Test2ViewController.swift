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
    var selectionFormattedAddress: String = "Tokyo Japan"
    //var selectionPlusCode: GMSPlusCode!
    
    
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
    }
    

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        performSegue(withIdentifier: "Map View To Manual View", sender: self)
        return true
    }
    
    // Push the map results to ManualAddressViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Map View To Manual View") {
            let destinationVC = segue.destination as! ManualAddressViewController

            let formattedAddressArray: [String] = selectionFormattedAddress.components(separatedBy: ", ")
            destinationVC.MapResults = formattedAddressArray
            
            destinationVC.MapCoordinates = selectionCoordinates
            
            
        }
    }
}



// MARK: - Handle the user's selection.
extension Test2ViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                     didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        
        // MARK: -Do something with the selected place.
        self.selectionName = place.name ?? "Location"
        self.selectionFormattedAddress = place.formattedAddress ?? "Formatted Address"
        self.selectionCoordinates[0] = place.coordinate.latitude
        self.selectionCoordinates[1] = place.coordinate.longitude
        
        
        //self.selectionPlusCode = GMSPlusCode()
        //self.selectionPlusCode = place.plusCode!
        
        
        
//        print("Place name: \(place.name)")
//        print("Place address: \(place.formattedAddress)")
//        print("Place attributions: \(place.attributions)")
//        print("Place Coordinates: \(place.coordinate.latitude) \(place.coordinate.longitude)")
//        print("vars", self.selectionName, self.selectionCoordinates, self.selectionFormattedAddress)
        
        // TODO
        
    
        
        
        // MARK: - Place Marker at selected Location.
        let coordinates = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        
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
