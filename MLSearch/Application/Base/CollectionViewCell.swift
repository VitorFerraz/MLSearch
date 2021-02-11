//
//  CollectionViewCell.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import UIKit
import DesignSystem

class CollectionViewCell: UICollectionViewCell, ViewConfigurator {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViewHierarchy() {}
    
    func setupConstraints() {}
    
    func configureViews() {}
    
}
