//
//  LoadingView.swift
//  DesignSystem
//
//  Created by Vitor Ferraz Varela on 11/02/21.
//

import UIKit

public protocol LoadingViewDelegate: AnyObject {
    func didTapRetry()
}

public enum LoadingViewState {
    case loading
    case error(message: String)
    case hide
}

public final class LoadingView: UIView, ViewConfigurator {
    
    public weak var delegate: LoadingViewDelegate?
    private var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Não foi possível realizar a busca"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        return view
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: .init(handler: { [weak self]_ in
            self?.didTapRetry()
        }))
        button.setTitle("Tentar novamente", for: .normal)
        
        return button
    }()
    
    private lazy var containerStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [titleLabel, retryButton, spinner])
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addViewHierarchy() {
        addSubview(containerStack)
    }
    
    public func setupConstraints() {
        containerStack.anchor(top: topAnchor,
                              leading: leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: trailingAnchor, padding: UIEdgeInsets(top: StyleGuide.Spacing.small,
                                                                       left: StyleGuide.Spacing.small,
                                                                       bottom: StyleGuide.Spacing.small,
                                                                       right: StyleGuide.Spacing.small))
    }
    
    public func configureViews() {
        backgroundColor = .white
    }
    
    private func didTapRetry() {
        delegate?.didTapRetry()
    }
    
    private func setTitle(with title: String) {
        self.title = title
    }
    
    public func setState(with state: LoadingViewState) {
        DispatchQueue.main.async {
            switch state {
            case .error(let message):
                self.error(with: message)
            case .hide:
                self.hide()
            case .loading:
                self.loading()
            }
        }
    }
    
    func loading() {
        titleLabel.isHidden = true
        retryButton.isHidden = true
        spinner.isHidden = false
        spinner.startAnimating()
        isHidden = false
    }
    
    func hide() {
        isHidden = true
        spinner.stopAnimating()
    }
    
    func error(with message: String) {
        titleLabel.isHidden = false
        retryButton.isHidden = false
        spinner.isHidden = true
        spinner.stopAnimating()
        setTitle(with: message)
        isHidden = false
    }
}
