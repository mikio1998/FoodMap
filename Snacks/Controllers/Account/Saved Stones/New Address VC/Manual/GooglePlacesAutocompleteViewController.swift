//
//  GooglePlacesAutocompleteViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/24/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit
import GoogleMaps

class GooglePlacesAutocompleteViewController: UIViewController {
    
    @IBOutlet weak var googleMapsContainer: UIView!
    var googleMapsView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        self.googleMapsView = GMSMapView(frame: self.googleMapsContainer.frame)
        self.view.addSubview(self.googleMapsView)
        
    }
    
    // MARK: - Action for search bar button.
    @IBAction func searchWithAddress(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self as? UISearchBarDelegate
        self.present(searchController, animated: true, completion: nil)
        
    }
    
    

}
