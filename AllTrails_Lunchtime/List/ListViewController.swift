//
//  ViewController.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/10/21.
//

import UIKit


class ListViewController: UIViewController {
    
    var collectionController = ListCollectionController()
    
    var restaurantsResults: RestaurantResults?
    
    var viewModel: RestaurantViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionController.setupCollectionView(view: self.view)
        self.collectionController.viewModel = self.viewModel
        self.view.backgroundColor = .systemBackground
        self.collectionController.collection?.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateRestaurants(note:)), name: NotificationNames.updateRestaurants, object: nil)
    }
    
    @objc func updateRestaurants(note: Notification) {
        self.collectionController.applySnapshot()
    }
    
    @objc func updateLocation(note: Notification) {
        self.collectionController.applySnapshot()
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let restaurant = self.viewModel?.restuarants[indexPath.item] else {
            return
        }
        let detailVC = DetailViewController(restaurant: restaurant)
        self.present(detailVC, animated: true) {
            
        }

    }
}

