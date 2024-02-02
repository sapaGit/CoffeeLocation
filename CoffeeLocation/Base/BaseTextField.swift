//
//  BaseTextField.swift
//  CoffeeLocation
//

import UIKit

private enum Constants {
    static let fontSize: CGFloat = 16.0
    static let padding: CGFloat = 10.0
    static let cornerRadius: CGFloat = 10.0
}

class BaseTextField: UITextField {

    // MARK: - Properties

    private let textPadding = UIEdgeInsets(
        top: Constants.padding,
        left: Constants.padding,
        bottom: Constants.padding,
        right: Constants.padding
    )

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override methods

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)

        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)

        return rect.inset(by: textPadding)
    }
}

// MARK: - Setup Subviews

extension BaseTextField {

    private func setupSubviews() {
        backgroundColor = .systemBackground
        layer.cornerRadius = Constants.cornerRadius
        font = .systemFont(ofSize: Constants.fontSize)
    }
}
