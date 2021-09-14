//
//  StarStack.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/13/21.
//

import UIKit

class StarStack: UIStackView {
    
    var userReviews: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.spacing = 8.0
        self.setupContent()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent() {
        self.axis = .horizontal
        for _ in 0..<5  {
            let star = UIImageView(frame: .zero)
            let starConfig = UIImage.SymbolConfiguration(pointSize: 12.0)
            star.image = UIImage(systemName: "star.fill", withConfiguration: starConfig)
            star.contentMode = .scaleAspectFill
            star.tintColor = .lightGray
            self.addArrangedSubview(star)
        }
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .lightGray
        label.text = "(0)"
        self.userReviews = label
        self.addArrangedSubview(label)
    }
    
    func updateContent(restaurant: Restaurant) {
        if let userReviews = restaurant.userRatingsTotal {
            self.userReviews?.text = "(\(userReviews))"
        }
        if let rating = restaurant.rating {
            let roundedRating = Int(rating.rounded())
            for i in 0..<roundedRating {
                if let imgView = self.arrangedSubviews[i] as? UIImageView {
                    imgView.tintColor = UIColor(named: "ATYellow") ?? .yellow
                }
            }
        }
    }
}
