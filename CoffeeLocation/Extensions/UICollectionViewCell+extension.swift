//
//  UICollectionViewCell+extension.swift
//  CoffeeLocation
//

import UIKit

extension UICollectionViewCell: TypeDescribable {
}

public extension UICollectionViewCell {
    /// A static property `reuseIdentifier` that returns the type's name as the reuseIdentifier.
    static var reuseIdentifier: String {
        typeName
    }

    func shadowDecorate() {
        let radius: CGFloat = 6
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
