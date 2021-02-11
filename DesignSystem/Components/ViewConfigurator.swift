//
//  ViewConfigurator.swift
//  DesignSystem
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation

public protocol ViewConfigurator: AnyObject {
    func setup()
    func addViewHierarchy()
    func setupConstraints()
    func configureViews()
}

public extension ViewConfigurator {
    func setup() {
        addViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
