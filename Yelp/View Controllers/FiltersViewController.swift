//
//  FiltersViewController.swift
//  Yelp
//
//  Created by phungducchinh on 6/22/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func filterUpdate(didUpdate: Filter)
}

class FiltersViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
   
    var delegate: FilterViewControllerDelegate?

    var filterModelBefore = Filter()
    var filterModeAfter = Filter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        filterModeAfter = filterModelBefore
        // Do any additional setup after loading the view.
    }

    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
            self.delegate?.filterUpdate(didUpdate: self.filterModelBefore)
        }
    }
    
    @IBAction func onSave(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
            self.delegate?.filterUpdate(didUpdate: self.filterModeAfter)
        }
    }

}
extension FiltersViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Deal"
        case 1: return "Distance"
        case 2: return "Sort By"
        case 3: return "Category"
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 : return 1
        case 1: return filterModeAfter.distance.count
        case 2: return filterModeAfter.sortBy.count
        case 3: return filterModeAfter.categories.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as! FiltersCell
            cell.config(with: "Offering a Deal", isOn: filterModeAfter.isDeal)
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "distanceCell") as! DataCell
            cell.config(name: filterModeAfter.distance[indexPath.row].name, isCheck: filterModeAfter.distance[indexPath.row].isOn)
            print("\(cell.nameLb.text) - \(cell.isCheck)")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "distanceCell") as! DataCell
            cell.config(name: filterModeAfter.sortBy[indexPath.row].name, isCheck: filterModeAfter.sortBy[indexPath.row].isOn)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as! FiltersCell
            cell.config(with: filterModeAfter.categories[indexPath.row].name, isOn: filterModeAfter.categories[indexPath.row].isOn)
            cell.delegate = self
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: break
        case 1:
            for index in 0...filterModeAfter.distance.count-1 {
                filterModeAfter.distance[index].isOn = false
                if index == indexPath.row {
                    filterModeAfter.distance[index].isOn = true
                }
            }
            tableView.reloadData()
        case 2:
            for index in 0...filterModeAfter.sortBy.count-1 {
                filterModeAfter.sortBy[index].isOn = false
                if index == indexPath.row {
                    filterModeAfter.sortBy[index].isOn = true
                }
            }
            tableView.reloadData()
        default: break
        }
    }
}

// MARK: delegate
    extension FiltersViewController: FiltersCellDelegate {
        func filtersCellDelegate(filterCell: FiltersCell, didValueChange value : Bool) {
            let index = tableView.indexPath(for: filterCell)
            if index?.section == 0 {
                filterModeAfter.isDeal = value
            }else if index?.section == 3 {
                filterModeAfter.categories[(index?.row)!].isOn = value
            }
            print("\(filterModeAfter.categories[(index?.row)!].name) : \(filterModeAfter.categories[(index?.row)!].isOn) ")
        }
        
}
