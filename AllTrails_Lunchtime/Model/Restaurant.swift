//
//  Restaurant.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/10/21.
//

import Foundation
import CoreLocation

struct RestaurantResults: Codable {
    let results: [Restaurant]
}

struct Restaurant: Codable, Hashable {
    let businessStatus: String?
    let geometry: Geometry?
    let name: String?
    let photos: [Photo]?
    let priceLevel: Int?
    let types: [String]?
    let userRatingsTotal: Int?
    let rating: Double?
    let placeId: String?
    
    
    enum CodingKeys: String, CodingKey {
        case businessStatus = "business_status"
        case geometry
        case name
        case photos
        case priceLevel = "price_level"
        case types
        case userRatingsTotal = "user_ratings_total"
        case rating
        case placeId = "place_id"
    }
}

//MARK: Location Model
struct Geometry: Codable, Hashable {
    let location: Coordinates
}

struct Coordinates: Codable, Hashable {
    let lat: Double
    let lng: Double
}

//MARK: Photos Model
struct Photo: Codable, Hashable {
    let photoReference: String?
    let height: Int?
    let width: Int?
    
    enum CodingKeys: String, CodingKey {
        case photoReference = "photo_reference"
        case height
        case width
    }
}

//MARK: Example results from PlacesAPI
//{
//            "business_status": "OPERATIONAL",
//            "geometry": {
//                "location": {
//                    "lat": 43.6160124,
//                    "lng": -116.2010522
//                },
//                "viewport": {
//                    "northeast": {
//                        "lat": 43.61733377989271,
//                        "lng": -116.1998499701073
//                    },
//                    "southwest": {
//                        "lat": 43.61463412010727,
//                        "lng": -116.2025496298927
//                    }
//                }
//            },
//            "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/restaurant-71.png",
//            "icon_background_color": "#FF9E67",
//            "icon_mask_base_uri": "https://maps.gstatic.com/mapfiles/place_api/icons/v2/restaurant_pinlet",
//            "name": "Boise Fry Company",
//            "opening_hours": {
//                "open_now": false
//            },
//            "photos": [
//                {
//                    "height": 3024,
//                    "html_attributions": [
//                        "<a href=\"https://maps.google.com/maps/contrib/111977541039028264588\">Shaghayegh Shariat</a>"
//                    ],
//                    "photo_reference": "Aap_uEDaP8CXd_LmDVkh_YeBggUzmbnofct3i42277VPT5DrfhKZ7qZf-lX1O8iwiBCSIXjBlpugudVyyHib3m-vs8z2qqTHZBsAUIu_LBPp0ILjqZerjSKeIr1VhyVEMAqSJyBysbduMk26RzEsfdszPalxVpdhQIBuv0mc_43JRadlthKi",
//                    "width": 4032
//                }
//            ],
//            "place_id": "ChIJ55my6v74rlQRhULfdtnCFqY",
//            "plus_code": {
//                "compound_code": "JQ8X+CH Boise, Idaho",
//                "global_code": "85M5JQ8X+CH"
//            },
//            "price_level": 2,
//            "rating": 4.4,
//            "reference": "ChIJ55my6v74rlQRhULfdtnCFqY",
//            "scope": "GOOGLE",
//            "types": [
//                "restaurant",
//                "food",
//                "point_of_interest",
//                "establishment"
//            ],
//            "user_ratings_total": 1553,
//            "vicinity": "204 N Capitol Blvd, Boise"
//        }
