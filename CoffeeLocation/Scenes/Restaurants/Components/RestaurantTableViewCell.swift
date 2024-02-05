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
}

final class RestaurantsTableViewCell: BaseTableViewCell {

    // MARK: - Properties

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .labelText

        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .descriptionText

        return label
    }()

    private lazy var backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .buttonText
        view.layer.cornerRadius = Constants.backgroundCornerRadius

        return view
    }()
}

// MARK: - Internal methods
extension RestaurantsTableViewCell {

    func configure(model: RestaurantsModel) {
        nameLabel.text = model.name
        descriptionLabel.text = model.point.latitude
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
            $0.leading.equalToSuperview().inset(8)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-8)
            $0.leading.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(Constants.padding)
        }

        backgroundViewCell.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.backgroundInset)
        }
    }
}

