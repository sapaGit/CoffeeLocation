//
//  BaseButton.swift
//  CoffeeLocation
//

import UIKit
import SnapKit

private enum Constants {
    static let cornerRadius: CGFloat = 22.0
    static let fontSize: CGFloat = 15.0
    static let heightSize: CGFloat = 44.0
}

final class BaseButton: UIButton {
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Subviews

extension BaseButton {

    func setupSubviews() {
        backgroundColor = .buttonBackground
        setTitleColor(.buttonText, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .bold)
        layer.cornerRadius = Constants.cornerRadius

        setupConstraints()
    }

    func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(Constants.heightSize)
        }
    }
}
