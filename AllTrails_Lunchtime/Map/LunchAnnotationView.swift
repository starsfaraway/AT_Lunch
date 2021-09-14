//
//  LunchAnnotationView.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/14/21.
//

import MapKit
import UIKit

class LunchAnnotationView: MKAnnotationView {
    
    var restaurant: Restaurant?
    lazy var detailView = DetailViewContent(frame: .zero, hideLikes: true)

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.detailCalloutAccessoryView = detailView
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                    detailView.widthAnchor.constraint(equalToConstant: 300),
                    detailView.heightAnchor.constraint(equalToConstant: 100)
                ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContent() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame.size = CGSize(width: 200, height: 100)
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
    }
    
}
