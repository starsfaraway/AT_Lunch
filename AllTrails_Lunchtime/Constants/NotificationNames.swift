//
//  NotificationNames.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/14/21.
//

import Foundation

enum NotificationNames {
    static let updateLocation = NSNotification.Name("at_update_location")
    static let updateRestaurants = NSNotification.Name("at_update_restaurants")
    static let updatedFilter = NSNotification.Name("at_update_filter")
    static let updatedSearchTerms = NSNotification.Name("at_udpate_search")
}
