//
//  SearchResultsController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/24/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit

// Method for GooglePlacesAutoComplete VC to load address/POI Location
protocol LocateOnTheMap{
    func locateWithLongitude(_ lon:Double, andLatitude lat:Double, andTitle title: String)
}

class SearchResultsController: UITableViewController {
    
    // searchResults hold all google API predictions
    var searchResults: [String]!
    var delegate: LocateOnTheMap!
    
    
    // Create a URLSession and initialize it with a default session configuration.
    let defaultSession = URLSession(configuration: .default)
    // Declare URLSessionDataTask, used to make a GET request to GMS when the user performs a search.
    // The data task will be re-initialized each time the user enters a new search string.
    var dataTask: URLSessionDataTask?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Empty array for the searchResults variable to work with later
        self.searchResults = Array()
        
        // Register the current class as the one to use when creating table cells.
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)

        cell.textLabel?.text = self.searchResults[indexPath.row]

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1
        // Dismiss the presented search results controller.
        // When user clicks on tableView row, tableView should dismiss to
        // display the selected address/POI on the map.
        self.dismiss(animated: true, completion: nil)
        
        
        
        
//        // 2
//        // Modify the selected address to readable format for parameter of Google Geocode API url.
//        // Whitespaces converted to % symbols.
//        //let correctedAddress: String! = self.searchResults[indexPath.row].addingPercentEncoding(withAllowedCharacters: NSCharacterSet.symbols)
//
//        // API url to request, and proceed an NSURLSession task
//        // through the asynchronous dataTaskWithURL method of the NSURLSession class.
//       let url = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=\(correctedAddress)&sensor=false")
////
////        // TODO: Read url data
////
////        let task = URLSession.shared.dataTask(with: url!) { (data, response, err) -> Void in
////
////            do {
////                if data != nil {
////                    let dict = try JSONSerialization.jsonObject(with: data!, options: )
////                }
////            }
////
////        }
//        // MARK: urlssession
//
////        // Create a URLSession and initialize it with a default session configuration.
////        let defaultSession = URLSession(configuration: .default)
////        // Declare URLSessionDataTask, used to make a GET request to GMS when the user performs a search.
////        // The data task will be re-initialized each time the user enters a new search string.
////        var dataTask: URLSessionDataTask?
//
//
//        // 1
//        dataTask?.cancel()
//
//
//
//        if var correctedAddress = self.searchResults[indexPath.row].addingPercentEncoding(withAllowedCharacters: NSCharacterSet.symbols) {
//
//            guard let url = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=\(correctedAddress)&sensor=false") else {
//                return
//            }
//            //4
//            dataTask = defaultSession.dataTask(with: url, completionHandler: { (data, response, err) in
//                defer {
//                    self.dataTask = nil
//                }
//
//                //5
//                if let err = err {
//                    self.errorMessage += "DataTask error: " + err.localizedDescription + "\n"
//                } else if
//                    let data = data,
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode == 200
//                                            {
//
//                    // TODO: parse the response data into array.
//                    //self.updateSearchResults(data)
//
//                    // 6
//                    DispatchQueue.main.async {
//                      completion(self?.tracks, self?.errorMessage ?? "")
//
//                    }
//
//
//            })
//
//
//
//
//
//        }
//
//        // 2
//        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
//          urlComponents.query = "media=music&entity=song&term=\(searchTerm)"
//          // 3
//          guard let url = urlComponents.url else {
//            return
//          }
//          // 4
//          dataTask =
//            defaultSession.dataTask(with: url) { [weak self] data, response, error in
//            defer {
//              self?.dataTask = nil
//            }
//            // 5
//            if let error = error {
//              self?.errorMessage += "DataTask error: " +
//                                      error.localizedDescription + "\n"
//            } else if
//              let data = data,
//              let response = response as? HTTPURLResponse,
//              response.statusCode == 200 {
//              self?.updateSearchResults(data)
//              // 6
//              DispatchQueue.main.async {
//                completion(self?.tracks, self?.errorMessage ?? "")
//              }
//            }
//          }
//          // 7
//          dataTask?.resume()
//        }

        
        
        
        
        
        
        
        


        
        
    }
    
//    override func tableView(tableView: UITableView,
//            didSelectRowAtIndexPath indexPath: NSIndexPath){
//       // 1
//       self.dismissViewControllerAnimated(true, completion: nil)
//       // 2
//       let correctedAddress:String! = self.searchResults[indexPath.row].stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.symbolCharacterSet())
//       let url = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=\(correctedAddress)&sensor=false")
//
//       let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
//       // 3
//       do {
//           if data != nil{
//              let dic = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as!  NSDictionary
//
//              let lat = dic["results"]?.valueForKey("geometry")?.valueForKey("location")?.valueForKey("lat")?.objectAtIndex(0) as! Double
//              let lon = dic["results"]?.valueForKey("geometry")?.valueForKey("location")?.valueForKey("lng")?.objectAtIndex(0) as! Double
//              // 4
//              self.delegate.locateWithLongitude(lon, andLatitude: lat, andTitle: self.searchResults[indexPath.row] )
//           }
//        }catch {
//           print("Error")
//        }
//    }
//    // 5
//    task.resume()
//    }
    
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
