//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var businesses: [Business]!
    var name = [String]()
     var searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        Business.search(with: "") { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses

                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
                self.tableView.reloadData()
            }
        }

        // Example of Yelp search with more search options specified
        /*
        Business.search(with: "Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses

                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
        }
        */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let filterVC = navController.viewControllers.first as! FiltersViewController
        filterVC.delegate = self as! FiltersViewControllerDelegate
    }

}


extension BusinessesViewController:  UITableViewDataSource, UITableViewDelegate,   UISearchBarDelegate, FiltersViewControllerDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if businesses != nil {
                return businesses.count
            } else {
                return 0
            }
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell") as! BusinessCell
            
            cell.business = businesses[indexPath.row]
            
            return cell
        }
        
    
    func filtersViewController(filterVC: FiltersViewController, didUpdateFilters filters: [String]) {
        print(filters)
        Business.search(with: "", sort: nil, categories: filters, deals: nil) { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                
        
                self.tableView.reloadData()
            }
        }
    }
        
        func createSearchBar(){
           
            searchBar.showsCancelButton = false
            searchBar.placeholder = "Search here"
            searchBar.delegate = self
            self.navigationItem.titleView = searchBar
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            let filter = self.name.filter({ (text) -> Bool in
                let tmp : NSString = text as NSString
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            Business.search(with: "") { (businesses: [Business]?, error: Error?) in
                if filter.count == 0 {
                    self.businesses = businesses
                } else {
                    self.businesses.removeAll()
                    var i = 0
                    for business in businesses! {
                        for filtername in filter {
                            if business.name == filtername{
                                self.businesses.insert(business, at: i)
                                i+=1
                            }
                        }
                    }
                }
                self.tableView.reloadData()
            }
        }

}
