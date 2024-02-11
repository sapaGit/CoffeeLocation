//
//  OrderTableViewCell.swift
//  CoffeeLocation
//

import UIKit
import SnapKit

private enum Constants {
    static let backgroundCornerRadius: CGFloat = 10.0
    static let padding: CGFloat = 20.0
    static let backgroundInset: CGFloat = 3.0
}

final class OrderTableViewCell: BaseTableViewCell {

    // MARK: - Properties

    weak var stepperDelegate: StepperWasChangedDelegate?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .labelText

        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .descriptionText

        return label
    }()

    private lazy var stepperView: CustomStepper = {
        let stepper = CustomStepper()

        stepper.tintColor = .labelText
        stepper.addTarget(self, action: #selector(stepperChangedValueAction), for: .valueChanged)

        return stepper
    }()

    private lazy var backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .buttonText
        view.layer.cornerRadius = Constants.backgroundCornerRadius

        return view
    }()

    // MARK: - Actions

    @objc
    private func stepperChangedValueAction(sender: CustomStepper) {
        stepperDelegate?.stepperWasChanged(tag: sender.tag, stepperValue: sender.currentValue)
    }
}

// MARK: - Internal methods
extension OrderTableViewCell {

    func configure(model: Order, index: Int) {
        nameLabel.text = model.name
        priceLabel.text = "\(model.price) руб"
        stepperView.currentValue = model.amount
        stepperView.tag = index
    }
}

// MARK: - Setup Subviews

extension OrderTableViewCell {
    override func setupSubviews() {
        super.setupSubviews()

        backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
    }

    override func embedSubviews() {
        backgroundViewCell.addSubviews(
            nameLabel,
            priceLabel,
            stepperView
        )
        addSubviews(backgroundViewCell)
    }

    override func setupConstraints() {
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.padding)
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.equalTo(stepperView.snp.leading).inset(-10)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-8)
            $0.leading.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(Constants.padding)
        }

        stepperView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(priceLabel.snp.height)
        }

        backgroundViewCell.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.backgroundInset)
        }
    }
}
