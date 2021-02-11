//
//  StyleGuide.swift
//  DesignSystem
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import UIKit
public struct StyleGuide {
    public struct SearchBar {
        public static let font: UIFont = UIFont.preferredFont(forTextStyle: .subheadline)
        public static let textColor: UIColor = .white
        public static let tintColor: UIColor = .clear
    }
    
    public struct CollectionView {
        public static let backgroundColor: UIColor         = .clear
        public static let itemSize: CGSize                 = CGSize(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.5)
        public static let minimumLineSpacing: CGFloat      = 50.0
        public static let minimumInteritemSpacing: CGFloat = 50.0
        public static let sectionInset: UIEdgeInsets       = .init(top: 100, left: 80, bottom: 100, right: 80)
    }
    
    public struct CardLabel {
        public static let titleFont: UIFont = UIFont.preferredFont(forTextStyle: .title1)
        public static let descriptionFont: UIFont = UIFont.preferredFont(forTextStyle: .body)
    }
    
    public struct Spacing {
        public static let minimal: CGFloat = 8
        public static let small: CGFloat = 16
        public static let base: CGFloat = 24
    }
    
    public struct Color {
        public static let primary = UIColor(red: 1.00, green: 0.95, blue: 0.35, alpha: 1.00)
        
        public struct Background {
            public static let lightGray = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        }
        
        public struct Text {
            public static let primary = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        }
    }
}
