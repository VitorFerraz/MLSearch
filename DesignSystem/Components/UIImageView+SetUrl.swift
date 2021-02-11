//
//  UIImageView+SetUrl.swift
//  DesignSystem
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import UIKit
import RequestNetwork

public extension UIImageView {
    func setImageFrom(url: String?) {
        guard let urlUnwrapped = url, let urlImage = URL(string: urlUnwrapped) else {
            image = nil
            return
        }
        image = nil
        startActivity()
        let service: DownloadService = .downloadImageFrom(url: urlImage)
        NetworkManager<DownloadService>().downloadImage(service: service) { [weak self] (result) in
            switch result {
            case .success(let image):
                self?.image = image
            case .failure:
                self?.image = nil
            }
            self?.stopActivity()
        }
    }
}

extension UIView {
    fileprivate struct AssociatedObjectKeys {
        static var activityIndicator: UInt8 = 0
    }
    
    fileprivate var activiyIndicator: UIActivityIndicatorView? {
        get { return objc_getAssociatedObject(self, &AssociatedObjectKeys.activityIndicator) as? UIActivityIndicatorView }
        set { objc_setAssociatedObject(self, &AssociatedObjectKeys.activityIndicator, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    fileprivate func setupActiviyIndicator() {
        if let act = activiyIndicator {
            if !subviews.contains(act) {
                addSubview(act)
                setupActivityConstraints()
            }
        } else {
            let actFrame = CGRect(x: 0, y: 0, width: 25, height: 25)
            activiyIndicator = UIActivityIndicatorView(frame: actFrame)
            activiyIndicator?.hidesWhenStopped = true
            addSubview(activiyIndicator!)
            setupActivityConstraints()
        }
    }
    
    fileprivate func setupActivityConstraints() {
        activiyIndicator?.translatesAutoresizingMaskIntoConstraints = false
        activiyIndicator?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activiyIndicator?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func startActivity(with style: UIActivityIndicatorView.Style = .large) {
        setupActiviyIndicator()
        activiyIndicator?.style = style
        activiyIndicator?.startAnimating()
    }
    
    func stopActivity() {
        activiyIndicator?.stopAnimating()
    }
}


