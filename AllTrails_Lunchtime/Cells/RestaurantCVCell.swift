//
//  RestaurantCVCell.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/10/21.
//

import UIKit

class RestaurantCVCell: UICollectionViewCell {
    static let reuseId = "com.at.takehome.restaurant.lunch"
    
    var contentDetails: DetailViewContent?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupContent()
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.cornerRadius = 8.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent() {
        let details = DetailViewContent(frame: self.contentView.frame)
        self.contentView.addSubview(details)
        self.contentDetails = details
        let constraints = [
            details.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            details.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 8.0),
            details.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0),
            details.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 16.0),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func updateContent(restaurant: Restaurant) {
        self.contentDetails?.updateContent(restaurant: restaurant)
    }
}
