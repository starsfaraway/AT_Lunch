//
//  DetailVerticalStack.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/13/21.
//

import UIKit

class DetailVerticalStack: UIStackView {
    
    var starStack: StarStack?
    var pricynessLabel: UILabel?
    var restaurantName: UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupContent()
        self.alignment = .center
        self.spacing = 8.0
        self.distribution = .fillProportionally
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent() {
        self.axis = .vertical
        
        let name = UILabel(frame: .zero)
        name.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        name.tintColor = UIColor.gray
        name.text = "Restaurant Name"
        self.restaurantName = name
        self.addArrangedSubview(name)
        
        let stars = StarStack()
        self.starStack = stars
        self.addArrangedSubview(stars)
        
        let price = UILabel(frame: .zero)
        price.font = .systemFont(ofSize: 12.0)
        price.textColor = .lightGray
        price.text = "$ - Closed"
        self.pricynessLabel = price
        self.addArrangedSubview(price)
        
    }
    
    func updateContent(restuarant: Restaurant) {
        self.restaurantName?.text = restuarant.name
        var dollarString: String = ""
        for _ in 0..<(restuarant.priceLevel ?? 0) {
            dollarString.append("$")
        }
        self.pricynessLabel?.text = "\(dollarString) - \(restuarant.businessStatus ?? "")"
        self.starStack?.updateContent(restaurant: restuarant)
    }
}
