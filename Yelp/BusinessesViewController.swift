//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MBProgressHUD

struct MyVariables {
    static var latitud = 0.0
    static var longitud = 0.0
    static var latitudes: [Double] = []
    static var longitudes: [Double] = []
    static var names: [String] = []
    static var urls: [String] = []
    static var mapUrl: String!
}

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate{
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var tableView: UITableView!
    var isMoreDataLoading = false
    var businesses: [Business]!
    var searchTxt : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup searchbar
        let searchBar = UISearchBar()
        
        searchBar.delegate = self
        searchBar.placeholder = "Restaurants"
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        //set custom bar button
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "map"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(tapped), for: UIControlEvents.touchDown)
        button.frame = CGRect(x: 0, y : 0, width : 80, height : 55)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        Business.searchWithTerm(term: "Mexican", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    MyVariables.latitudes.append(business.latitude!)
                    MyVariables.longitudes.append(business.longitude!)
                    MyVariables.names.append(business.name!)
                    MyVariables.urls.append(business.webUrl!)
                }
            }
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Business.searchWithTerm(term: searchText,  completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.searchTxt = searchText
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    
                    MyVariables.latitudes.append(business.latitude!)
                    MyVariables.longitudes.append(business.longitude!)
                    MyVariables.names.append(business.name!)
                    MyVariables.urls.append(business.webUrl!)
                }
            }}
        )}
    
    
    func tapped() { performSegue(withIdentifier: "map", sender: nil) }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return businesses?.count ?? 0}
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as! businessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myWebView = self.storyboard?.instantiateViewController(withIdentifier: "LinkViewController") as! webViewControl
        myWebView.url = NSURL(string:  MyVariables.urls[indexPath.row])! as URL
       MBProgressHUD.showAdded(to: self.view, animated: true)
        self.present(myWebView, animated: true, completion: nil)
         
    }
   

}
