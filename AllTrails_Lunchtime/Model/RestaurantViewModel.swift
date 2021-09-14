//
//  RestaurantViewModel.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/13/21.
//

import Foundation
import CoreLocation
import Combine
import UIKit

protocol ViewModelUpdated : NSObjectProtocol {
    func updateView(restuarants: [Restaurant])
}

class RestaurantViewModel {
    let api = PlacesAPI()
    weak var delegate: ViewModelUpdated?
    private(set) var restuarants: [Restaurant] = []  {
        didSet {
            self.delegate?.updateView(restuarants: restuarants)
        }
    }
    var currentLocation: CLLocation = CLLocation(latitude: 43.6, longitude: -116.2) {
        didSet {
            let note = Notification(name: NotificationNames.updateLocation, object: nil, userInfo: ["location":currentLocation])
            NotificationCenter.default.post(note)
        }
    }
    
    func updateRestaurants(radius: Double = 5000.0, keyword: String = "") -> AnyCancellable {
        let params = [
            "location": "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)",
            "key": PlacesEndpoints.key,
            "radius": "\(radius)",
            "types": "restaurant",
            "keyword": keyword
        ]
        return api.getCloseRestaurants(params: params)
            .receive(on: RunLoop.main)
            .catch({ error -> AnyPublisher<RestaurantResults, Never> in
                print(error)
                return Just(RestaurantResults(results: [])).eraseToAnyPublisher()
            })
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { restaurantResult in
                self.restuarants = restaurantResult.results
                print("r count: \(String(describing: restaurantResult))");
            })

        }
}

