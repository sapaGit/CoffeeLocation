//
//  BaseCollectionViewCell.swift
//  CoffeeLocation
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupSubviews()
    }

    // MARK: - Override method

    override func layoutSubviews() {
        super.layoutSubviews()

        updateSubviews()
    }
}

// MARK: - Setup Subviews

@objc extension BaseCollectionViewCell {

    /// Sets up the items subviews and their constraints.
    func setupSubviews() {

        embedSubviews()
        setupConstraints()
    }

    /// Updates the items subviews after layout updates.
    func updateSubviews() {}
    /// Embeds subviews within the item.
    func embedSubviews() {}
    /// Sets up constraints for subviews.
    func setupConstraints() {}
}
