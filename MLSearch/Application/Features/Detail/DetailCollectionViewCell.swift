//
//  DetailCollectionViewCell.swift
//  MLSearch
//
//  Created by Vitor Ferraz Varela on 12/02/21.
//

import UIKit
import DesignSystem

public protocol DetailCollectionViewCellDelegate: AnyObject {
    func openExternalLink(link: URL?)
}

class DetailCollectionViewCell: CollectionViewCell {
    weak var delegate: DetailCollectionViewCellDelegate?
    private var externalLink: URL?
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.font = UIFont.preferredFont(forTextStyle: .title1)
        return view
    }()
    
    private let priceLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGreen
        view.font = UIFont.preferredFont(forTextStyle: .title1)
        return view
    }()
    
    private let freeShippingLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .title2)
        return view
    }()
    
    private let addressLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return view
    }()
    
    private lazy var productImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.constrainHeight(self.frame.height * 0.3)
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var openExternalLinkButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: .init(handler: { [weak self]_ in
            self?.didTapOpenExternalLink()
        }))
        button.setTitle("Abrir no navegador", for: .normal)
        
        return button
    }()

    private func didTapOpenExternalLink() {
        delegate?.openExternalLink(link: externalLink)
    }
    
    private lazy var containerStack: UIStackView = {
        let container = UIStackView(arrangedSubviews: [titleLabel, priceLabel, freeShippingLabel])
        container.axis = .vertical
        container.alignment = .leading
        let stack = UIStackView(arrangedSubviews: [productImageView,
                                                   container,
                                                   addressLabel,
                                                   openExternalLinkButton,
                                                   UIView()])
        stack.alignment = .fill
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
                              trailing: contentView.trailingAnchor, padding: .init(top: StyleGuide.Spacing.base,
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
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        freeShippingLabel.text = viewModel.freeShipping
        productImageView.setImageFrom(url: viewModel.image)
        externalLink = viewModel.link
        addressLabel.text = viewModel.address
    }
}
