//
//  Test2ViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/26/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces



class Test2ViewController: UIViewController {


    @IBOutlet weak var MapView: GMSMapView!
    
    // Search selection data:
    // Place Name
    var selectionName: String = "Tokyo"
    // Latitude, longitude, initially at Tokyo.
    var selectionCoordinates: [Double] = [35.681708, 139.767053]
    var selectionFormattedAddress: [String] = ["", ""]
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
    
    // MARK:  - Marker is dragged.
    // Update location coordinates and address.
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("Ended dragging!")
        
        // MARK: Selection Coordinates
        self.selectionCoordinates[0] = marker.position.latitude
        self.selectionCoordinates[1] = marker.position.longitude
        
        // MARK: Selection Address
        GeocodeHelper(lat: selectionCoordinates[0], long: selectionCoordinates[1])
    }
 
    
    // MARK: - MyLocationButton Tapped.
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        print("MyLocationButton tapped.")

        // Coordinates
        let coordinates = CLLocationCoordinate2D(latitude: currentUserLocation.latitude, longitude: currentUserLocation.longitude)

        // MARK: Place Marker at selected Location.
        self.mapMarker = GMSMarker(position: coordinates)
        self.mapMarker?.title = "現在位置"
        self.mapMarker?.isDraggable = true
        self.mapMarker?.map = self.MapView
        
        // MARK: Change selectionCoordinates values
        // So we can pass correct data if marker is tapped.
        self.selectionCoordinates = [currentUserLocation.latitude, currentUserLocation.longitude]
        
        // MARK: Change selectionFormattedAddress values
        // So we can pass correct data if marker is tapped.
        GeocodeHelper(lat: currentUserLocation.latitude, long: currentUserLocation.longitude)
        
        // MARK: Animate map to new Location.
        let location = GMSCameraPosition.camera(withLatitude: currentUserLocation.latitude, longitude: currentUserLocation.longitude, zoom: 16.0)
        // Animate MapView to the selected location.
        self.MapView.animate(to: location)
        return true
    }
    
    // MARK: Marker Tapped
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        performSegue(withIdentifier: "Map View To Manual View", sender: self)
        return true
    }
    // MARK: Push the map results to ManualAddressViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Map View To Manual View") {
            let destinationVC = segue.destination as! ManualAddressViewController
            
            // Add two empty "" to beginning
            // of selectionFormattedAddress
            // Empty strings for Name and Description
            
            selectionFormattedAddress.insert("x", at: 0)
            selectionFormattedAddress.insert("y", at: 0)
            
            destinationVC.AddressData = selectionFormattedAddress
            destinationVC.MapCoordinates = selectionCoordinates

        }
    }
    
    // MARK: Geocode helper function
    func GeocodeHelper(lat: Double, long: Double) {
        // MARK: input: Latitude and Longitude
        // Updates selectionFormattedAddress array values,
        // with new coordinate location.
        let coordinates = CLLocation(latitude: lat, longitude: long)
        
        CLGeocoder().reverseGeocodeLocation(coordinates, completionHandler: {(placemarks, err) -> Void in
            print(coordinates)
            guard err == nil else {
                print("Reverse geocoder failed with error" + err!.localizedDescription)
                return
            }
            guard placemarks!.count > 0 else {
                print("Problem with the data received from geocoder")
                return
            }
            let pm = placemarks![0]
            print(pm)
            let name = pm.name ?? ""
            let postalcode = pm.postalCode ?? ""
            let thoroughfare = pm.thoroughfare ?? ""
            let locality = pm.locality ?? ""
            let administrativeArea = pm.administrativeArea ?? ""
            let country = pm.country ?? ""
            
            self.selectionFormattedAddress = [name, postalcode, thoroughfare, locality, administrativeArea]
        })
    }
    
    
    
}


// MARK: - Handle the user's selection.
extension Test2ViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                     didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        
        // MARK: - Do something with the selected place.
        
        self.selectionName = place.name ?? "Location"
        
        // Formatted Address to array of strings:
        let placeAddress = place.formattedAddress ?? "Formatted Address"
        let formattedAddressArray: [String] = placeAddress.components(separatedBy: ", ")
        self.selectionFormattedAddress = formattedAddressArray

        // Selection coordinates.
        self.selectionCoordinates[0] = place.coordinate.latitude
        self.selectionCoordinates[1] = place.coordinate.longitude

        
        
        // MARK: - Place Marker at selected Location.
        let coordinates = CLLocationCoordinate2D(latitude: selectionCoordinates[0], longitude: selectionCoordinates[1])
        //let coordinates = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        self.mapMarker = GMSMarker(position: coordinates)
        self.mapMarker?.title = place.name
        self.mapMarker?.isDraggable = true
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


