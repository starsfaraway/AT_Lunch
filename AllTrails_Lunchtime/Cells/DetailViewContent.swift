//
//  DetailViewCell.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/10/21.
//

import UIKit

class DetailViewContent: UIStackView {

    var restaurantImage: UIImageView?
    var likeButton: UIButton?
    
    var vStack: DetailVerticalStack?


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.spacing = 16.0
        self.distribution = .fillProportionally
        self.setupContent()
    }
    
    convenience init(frame: CGRect, hideLikes: Bool) {
        self.init()
        self.likeShouldBe(hidden: hideLikes)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent() {
    
        let imageholder = UIView(frame: .zero)
        let imageView = UIImageView(frame: .zero)
        imageholder.addSubview(imageView)
        imageView.image = UIImage(named: "martis-trail")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.restaurantImage = imageView
        self.addArrangedSubview(imageholder)
        
        let stackView = DetailVerticalStack(frame: .zero)
        self.vStack = stackView
        self.addArrangedSubview(stackView)
        
        let heart = UIButton(frame: .zero)
        heart.setImage(UIImage(systemName: "heart"), for: .normal)
        heart.tintColor = UIColor(named: "ATGreen") ?? .green
        self.likeButton = heart
        self.addArrangedSubview(heart)
        heart.translatesAutoresizingMaskIntoConstraints = false
        imageholder.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            heart.widthAnchor.constraint(equalToConstant: 40.0),
            heart.heightAnchor.constraint(equalToConstant: 40.0),
            imageView.widthAnchor.constraint(equalToConstant: 60.0),
            imageView.heightAnchor.constraint(equalToConstant: 60.0),
            imageView.topAnchor.constraint(equalTo: imageholder.topAnchor, constant: 12.0),
            imageView.leadingAnchor.constraint(equalTo: imageholder.leadingAnchor, constant: 12.0),
            imageView.trailingAnchor.constraint(equalTo: imageholder.trailingAnchor, constant: 12.0),
            imageView.widthAnchor.constraint(equalToConstant: 84.0),
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func likeShouldBe(hidden: Bool) {
        self.likeButton?.isHidden = hidden
        guard let heart = self.likeButton else {
            return
        }
        let constraints = [
            heart.widthAnchor.constraint(equalToConstant: 0.0),
            heart.heightAnchor.constraint(equalToConstant: 0.0),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func updateContent(restaurant: Restaurant) {
        self.vStack?.updateContent(restuarant: restaurant)
        guard let ref = restaurant.photos?.first?.photoReference else {
            return
        }
        RestaurantImages.instance.getImage(photoReference: ref) { image, error in
            DispatchQueue.main.async {
                self.restaurantImage?.image = image
            }
        }
    }
    
    
}
