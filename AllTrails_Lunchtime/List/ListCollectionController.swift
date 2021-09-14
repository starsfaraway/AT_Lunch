//
//  ListCollectionController.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/10/21.
//

import UIKit
import Combine
import CoreLocation

fileprivate enum Section {
    case main
}

fileprivate typealias Datasource = UICollectionViewDiffableDataSource<Section, Restaurant>
fileprivate typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>

class ListCollectionController: NSObject {
    
    var collection: UICollectionView?
    var viewModel: RestaurantViewModel?
    
    func setupCollectionView(view: UIView) {
        let layout = UICollectionViewCompositionalLayout() {
            sectionIndex, layoutEnvironment in
            return ListLayout.cvLayout(layoutEnvironment: layoutEnvironment)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(RestaurantCVCell.self, forCellWithReuseIdentifier: RestaurantCVCell.reuseId)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        self.collection = collectionView
        self.applySnapshot()
    }
    
    fileprivate lazy var datasource = makeDatasource()
    
    fileprivate func makeDatasource() -> Datasource? {
        guard let cv = self.collection else {
            return nil
        }
        let datasource = Datasource(collectionView: cv) { collectionView, indexPath, theString in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCVCell.reuseId, for: indexPath) as! RestaurantCVCell
            if let restaurant = self.viewModel?.restuarants[indexPath.item] {
                cell.updateContent(restaurant: restaurant)
            }
            return cell
        }
        return datasource
    }
    
    func applySnapshot() {
        guard let vm = viewModel else {
            return
        }
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(vm.restuarants)
        datasource?.apply(snapshot, animatingDifferences: true)
    }
    
}
