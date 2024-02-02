//
//  UIStackView+extension.swift
//  CoffeeLocation
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }

    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
