//
//  DetailViewController.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/14/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var details = DetailViewContent()
    var restaurant: Restaurant?
    var dismiss: UIButton?
    
    convenience init(restaurant: Restaurant) {
        self.init()
        self.restaurant = restaurant
        self.view.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.addSubview(details)
        if let r = restaurant {
            details.updateContent(restaurant: r)
        }
        
        let dismissbutton = UIButton(frame: .zero)
        dismissbutton.setTitle("Dismiss", for: .normal)
        dismissbutton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        dismissbutton.backgroundColor = UIColor(named: "ATGreen")
        self.view.addSubview(dismissbutton)
        self.dismiss = dismissbutton
        details.translatesAutoresizingMaskIntoConstraints = false
        dismissbutton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissbutton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40.0),
            dismissbutton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40.0),
            dismissbutton.widthAnchor.constraint(equalToConstant: 100.0),
            dismissbutton.heightAnchor.constraint(equalToConstant: 40.0),
            details.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0),
            details.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0.0),
            details.widthAnchor.constraint(equalToConstant: 300.0),
            details.heightAnchor.constraint(equalToConstant: 100.0)
        ])
        
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true) {
            
        }
    }


}
