//
//  DetailCollectionViewCell.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 12/02/21.
//

import UIKit
import DesignSystem

class DetailCollectionViewCell: CollectionViewCell {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.font = UIFont.preferredFont(forTextStyle: .title3)
        return view
    }()
    
    private let priceLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGreen
        view.font = UIFont.preferredFont(forTextStyle: .callout)
        return view
    }()
    
    private let freeShippingLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .caption1)
        return view
    }()
    
    private let productImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.constrainWidth(80)
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()

    
    private lazy var containerStack: UIStackView = {
        let container = UIStackView(arrangedSubviews: [titleLabel, priceLabel, freeShippingLabel])
        container.axis = .vertical
        container.alignment = .leading
        let stack = UIStackView(arrangedSubviews: [productImageView,
                                                   container])
        stack.alignment = .center
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
                              trailing: contentView.trailingAnchor, padding: .init(top: 0,
                                                                                   left: StyleGuide.Spacing.base,
                                                                                   bottom: 0,
                                                                                   right: StyleGuide.Spacing.base))
    }
    
    
    private func setup() {
        layoutIfNeeded()
        backgroundColor = StyleGuide.Color.Background.lightGray
    }
    
    private func clean() {
        titleLabel.text = nil
        priceLabel.text = nil
        freeShippingLabel.text = nil
        productImageView.image = nil
    }
    
    func configureWith(viewModel: DetailViewModel) {
        titleLabel.text = "teste"
//        priceLabel.text = viewModel.price
//        freeShippingLabel.text = viewModel.freeShipping
//        productImageView.setImageFrom(url: viewModel.image)
    }
}
