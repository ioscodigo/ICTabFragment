//
//  ICTabCollectionViewCell.swift
//  ICTabFragment
//
//  Created by Digital Khrisna on 6/1/17.
//  Copyright © 2017 codigo. All rights reserved.
//

import UIKit

class ICTabCollectionViewCell: UICollectionViewCell {
    
    var tabNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = "Label"
        label.sizeToFit()
        
        return label
    }()
    
    var indicatorView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var indicatorTopSpaceConstraint: NSLayoutConstraint!
    private var indicatorHeightConstraint: NSLayoutConstraint!
    
    var indicatorTopSpace: CGFloat = 0 {
        didSet {
            indicatorTopSpaceConstraint.constant = indicatorTopSpace
        }
    }
    
    var indicatorHeight: CGFloat = 5 {
        didSet {
            indicatorHeightConstraint.constant = indicatorHeight
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.addSubview(tabNameLabel)
        tabNameLabel.translatesAutoresizingMaskIntoConstraints = false
        tabNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        tabNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        self.addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.widthAnchor.constraint(equalTo: tabNameLabel.widthAnchor, multiplier: 0.8).isActive = true
        indicatorTopSpaceConstraint = indicatorView.topAnchor.constraint(equalTo: tabNameLabel.bottomAnchor, constant: indicatorTopSpace)
        indicatorTopSpaceConstraint.isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: tabNameLabel.centerXAnchor, constant: 0).isActive = true
        indicatorHeightConstraint = indicatorView.heightAnchor.constraint(equalToConstant: indicatorHeight)
        indicatorHeightConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var reuseIdentifier: String? {
        return "ictabcollectionviewcell"
    }
}
