//
//  BaseButton.swift
//  CoffeeLocation
//


import UIKit
import SnapKit

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
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        layer.cornerRadius = 22

        setupConstraints()
    }

    func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(44)
        }
    }
}
