//
//  LunchAnnotation.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/13/21.
//

import MapKit

class LunchAnnotation: NSObject, MKAnnotation {

    static let reuseId = "com.alltrails.lunch.annotation"
    @objc dynamic var coordinate = CLLocationCoordinate2D(latitude: 37.779, longitude: -122.418)
    var title: String?
    var subtitle: String?
    var restuarant: Restaurant?

}
