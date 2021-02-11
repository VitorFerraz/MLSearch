//
//  ProductCollectionViewCell.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import UIKit
import DesignSystem

class ProductCollectionViewCell: CollectionViewCell {
    
    private lazy var containerStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    override func configureViews() {
        clean()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clean()
    }
    
    override func addViewHierarchy() {
        contentView.addSubview(containerStack)
       
    }
    
    override func setupConstraints() {
        containerStack.anchor(top: contentView.topAnchor,
                              leading: contentView.leadingAnchor,
                              bottom: contentView.bottomAnchor,
                              trailing: contentView.trailingAnchor)
    }
    
    
    private func setup() {
        layoutIfNeeded()
        backgroundColor = StyleGuide.Color.Background.lightGray
    }
    
    private func clean() {
        
    }
    
    func configureWith(viewModel: ProductViewModel) {
        
    }
}
