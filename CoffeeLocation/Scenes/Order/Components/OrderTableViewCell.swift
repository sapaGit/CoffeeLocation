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
    static let contentInset: CGFloat = 8.0
    static let stepperViewWidth: CGFloat = 80.0
    static let nameLabelFontSize: CGFloat = 18.0
    static let priceLabelFontSize: CGFloat = 14.0
    static let shadowOffset: CGFloat = 2.0
    static let shadowOpacity: Float = 0.5
}

final class OrderTableViewCell: BaseTableViewCell {

    // MARK: - Properties

    weak var stepperDelegate: StepperWasChangedDelegate?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: Constants.nameLabelFontSize, weight: .bold)
        label.textColor = .labelText

        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: Constants.priceLabelFontSize, weight: .light)
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
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = Constants.shadowOpacity
        view.layer.shadowOffset = CGSize(width: .zero, height: Constants.shadowOffset)
        view.layer.shadowRadius = Constants.shadowOffset

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
            $0.leading.equalToSuperview().inset(Constants.contentInset)
            $0.trailing.equalTo(stepperView.snp.leading).inset(-Constants.contentInset)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-Constants.contentInset)
            $0.leading.equalToSuperview().inset(Constants.contentInset)
            $0.bottom.equalToSuperview().inset(Constants.padding)
        }

        stepperView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.contentInset)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(Constants.stepperViewWidth)
            $0.height.equalTo(priceLabel.snp.height)
        }

        backgroundViewCell.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.backgroundInset)
        }
    }
}
