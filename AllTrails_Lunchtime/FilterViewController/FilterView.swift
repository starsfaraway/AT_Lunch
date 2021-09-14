//
//  FilterView.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/14/21.
//

import UIKit

class FilterView: UIView {
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var searchTextView: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    
    let nibName = "FilterView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        let nib = UINib(nibName: "FilterView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
}
