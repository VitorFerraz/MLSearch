//
//  CollectionViewCell.swift
//  DesignSystem
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import UIKit
public class CollectionViewCell: UICollectionViewCell, ViewConfigurator {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addViewHierarchy() {}
    
    public func setupConstraints() {}
    
    public func configureViews() {}
    
}
