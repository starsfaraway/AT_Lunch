//
//  PlacesAPIService.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/10/21.
//

import UIKit
import Combine
import CoreLocation

enum PlacesEndpoints {
    static let placesBase = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    static let imageBase = "https://maps.googleapis.com/maps/api/place/photo"
    //FIXME: Key is removed!!
    static let key = ""
}

class PlacesAPI {
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    private func doThing<T: Decodable>(request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .mapError { error -> Error in
                print("error: \(error)")
                return error
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

    }
    
    func getCloseRestaurants(params: [String: String]) -> AnyPublisher<RestaurantResults, Error> {
        var urlComponents = URLComponents(string: PlacesEndpoints.placesBase)
        var queryItems: [URLQueryItem] = []
        _ = params.map { (key: String, value: String) in
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponents?.queryItems = queryItems
        let request = URLRequest(url: urlComponents!.url!)
        
        return self.doThing(request: request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func getImage(photoReference: String, completionHandler: @escaping (UIImage?, Error?) -> ()) {
        var urlComponents = URLComponents(string: PlacesEndpoints.imageBase)
        urlComponents?.queryItems = [URLQueryItem(name: "photo_reference", value: photoReference),URLQueryItem(name: "key", value: PlacesEndpoints.key), URLQueryItem(name: "maxheight", value: "120"), URLQueryItem(name: "maxwidth", value: "120")]
        let request = URLRequest(url: urlComponents!.url!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            let image = UIImage(data: data!)
            completionHandler(image, nil)
        }
        .resume()
    }
}
