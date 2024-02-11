//
//  CustomStepper.swift
//  CoffeeLocation
//


import UIKit
import SnapKit

final class CustomStepper: UIControl {

    // MARK: - Properties
    
    var currentValue = 0 {
        didSet {
            currentValue = currentValue > 0 ? currentValue : 0
            currentStepValueLabel.text = "\(currentValue)"
        }
    }

    var font: UIFont = .monospacedDigitSystemFont(ofSize: 12, weight: UIFont.Weight.regular)

    var buttonsTitleColor: UIColor = .secondaryLabel

    private lazy var decreaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(buttonsTitleColor, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    private lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(buttonsTitleColor, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    private lazy var currentStepValueLabel: UILabel = {
        var label = UILabel()
        label.textColor = .tintColor
        label.textAlignment = .center
        label.text = "\(currentValue)"
        label.font = font
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc
    private func buttonAction(_ sender: UIButton) {
        switch sender {
        case decreaseButton:
            currentValue -= 1
        case increaseButton:
            currentValue += 1
        default:
            break
        }
        sendActions(for: .valueChanged)
    }
}

extension CustomStepper {
    func setupSubviews() {
        backgroundColor = .clear

        embedSubviews()
        setupConstraints()
    }

    /// Embeds subviews.
    func embedSubviews() {

        addSubviews(
            decreaseButton,
            currentStepValueLabel,
            increaseButton
        )
    }

    /// Setup constraints.
    func setupConstraints() {
        decreaseButton.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.35)
        }
        currentStepValueLabel.snp.makeConstraints {
            $0.leading.equalTo(decreaseButton.snp.trailing)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(increaseButton.snp.leading)
        }
        increaseButton.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.35)
        }
    }
}
