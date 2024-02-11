//
//  RestaurantTableViewCell.swift
//  CoffeeLocation
//

import UIKit
import SnapKit

private enum Constants {
    static let backgroundCornerRadius: CGFloat = 10.0
    static let padding: CGFloat = 20.0
    static let backgroundInset: CGFloat = 3.0
    static let contentInset: CGFloat = 8.0
    static let nameLabelFontSize: CGFloat = 18.0
    static let descriptionLabelFontSize: CGFloat = 14.0
    static let shadowOffset: CGFloat = 2.0
    static let shadowOpacity: Float = 0.5
}

final class RestaurantsTableViewCell: BaseTableViewCell {

    // MARK: - Properties

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: Constants.nameLabelFontSize, weight: .bold)
        label.textColor = .labelText

        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: Constants.descriptionLabelFontSize, weight: .light)
        label.textColor = .descriptionText

        return label
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
}

// MARK: - Internal methods

extension RestaurantsTableViewCell {

    func configure(model: RestaurantsModel, distanceDescription: String) {
        nameLabel.text = model.name
        descriptionLabel.text = "\(distanceDescription) от вас"
    }
}

// MARK: - Setup Subviews

extension RestaurantsTableViewCell {
    override func setupSubviews() {
        super.setupSubviews()

        backgroundColor = .clear
    }

    override func embedSubviews() {
        backgroundViewCell.addSubviews(nameLabel, descriptionLabel)
        addSubviews(backgroundViewCell)
    }

    override func setupConstraints() {
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.padding)
            $0.leading.equalToSuperview().inset(Constants.contentInset)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-Constants.contentInset)
            $0.leading.equalToSuperview().inset(Constants.contentInset)
            $0.bottom.equalToSuperview().inset(Constants.padding)
        }

        backgroundViewCell.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.backgroundInset)
        }
    }
}

