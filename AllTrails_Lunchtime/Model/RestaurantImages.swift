//
//  RestaurantImags.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/14/21.
//

import UIKit

class RestaurantImages: NSObject {
    
    static let instance = RestaurantImages()
    let imageCache = NSCache<NSString, UIImage>()
    let api = PlacesAPI()

    func getImage(photoReference: String, completionHandler: @escaping (UIImage?, Error?) -> ()) {
        let nsString = NSString(string: photoReference)
        if let cachedImage = self.imageCache.object(forKey: nsString) {
            completionHandler(cachedImage, nil)
        } else {
            api.getImage(photoReference: photoReference) { image, error in
                if (error != nil) {
                    completionHandler(UIImage(named: "martis-trail"), nil)
                }
                if let img = image {
                    self.imageCache.setObject(img, forKey: nsString)
                }
                completionHandler(image, nil)
            }
        }
    }
}
