//
//  FilterViewController.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/13/21.
//

import UIKit
import CoreLocation
import Combine

class FilterViewController: UIViewController {
    
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var filterView: FilterView!
    var embeddedTab: UITabBarController?
    
    let locationService = LocationService()
    let viewModel = RestaurantViewModel()
    private var tokens: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filterView.searchTextView.delegate = self
        self.filterView.filterButton.addTarget(self, action: #selector(updateRestaurants), for: .touchUpInside)
        toggleButton.backgroundColor = UIColor(named: "ATGreen") ?? .green
        toggleButton.setTitle("Map", for: .normal)
        toggleButton.setImage(UIImage(systemName: "location"), for: .normal)
        locationService.requestAuthorization()
        locationService.requestLocation()
        viewModel.delegate = self
        locationService.delegate = self
        let token = viewModel.updateRestaurants()
        tokens.append(token)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleButton?.addTarget(self, action: #selector(toggleTab), for: .touchUpInside)
        self.view.bringSubviewToFront(toggleButton!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "tabContainer") {
            guard let destination = segue.destination as? UITabBarController else {
                return
            }
            self.embeddedTab = destination
            self.embeddedTab?.tabBar.isHidden = true
            if let list = destination.viewControllers?.first as? ListViewController {
                list.viewModel = self.viewModel
            }
            if let map = destination.viewControllers?.last as? MapViewController {
                map.viewModel = self.viewModel
            }
            
        }
        
    }
    
    @objc func toggleTab() {
        guard let tab = self.embeddedTab else {
            return
        }
        tab.selectedIndex = (tab.selectedIndex + 1) % 2
        if (tab.selectedIndex == 0) {
            toggleButton.setTitle("Map", for: .normal)
            toggleButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        } else {
            toggleButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
            toggleButton.setTitle("List", for: .normal)
            
        }
    }
    
    @objc func updateRestaurants() {
        let token = self.viewModel.updateRestaurants(radius: 5000, keyword: self.filterView.searchTextView.text ?? "")
        tokens.append(token)
    }

}

extension FilterViewController: ViewModelUpdated {
    func updateView(restuarants: [Restaurant]) {
        let note = Notification.init(name: NotificationNames.updateRestaurants, object: nil, userInfo: ["restuarants":restuarants])
        NotificationCenter.default.post(note)
    }
    
    func updatedLocation(location: CLLocation) {
        let note = Notification.init(name: NotificationNames.updateRestaurants, object: nil, userInfo: ["location":location])
        NotificationCenter.default.post(note)
    }
}

extension FilterViewController: LocationUpdated {
    func updateLocation(location: CLLocation) {
        self.viewModel.currentLocation = location
        let token = self.viewModel.updateRestaurants()
        tokens.append(token)
        self.updatedLocation(location: location)
    }
}

extension FilterViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let token = self.viewModel.updateRestaurants(radius: 5000, keyword: searchText)
        tokens.append(token)
    }
}
