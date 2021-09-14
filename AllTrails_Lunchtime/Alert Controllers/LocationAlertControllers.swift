//
//  LocationAlertControllers.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/13/21.
//

import UIKit

struct LocationAlertConrtrollers {
    static func presentGoToSettings() -> UIAlertController? {
        let alert = UIAlertController(title: "Location Permission Required", message: "Please go to the app settings to allow locaiton", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Go to Settings", style: .default) { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if (UIApplication.shared.canOpenURL(url)) {
                UIApplication.shared.open(url, options: [:]) { _ in
                    
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        return alert
    }

}
