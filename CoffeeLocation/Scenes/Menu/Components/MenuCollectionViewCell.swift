//
//  MenuCollectionViewCell.swift
//  CoffeeLocation
//


import UIKit
import Kingfisher
import SnapKit

private enum Constants {
    static let radius: CGFloat = 10.0
    static let padding: CGFloat = 6.0
    static let iconSize: CGFloat = 20.0
}

protocol StepperWasChangedDelegate: AnyObject {
    func stepperWasChanged(tag: Int, stepperValue: Int)
}

final class MenuCollectionViewCell: BaseCollectionViewCell {

    // MARK: - Properties

    weak var stepperDelegate: StepperWasChangedDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .labelText

        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .descriptionText

        return label
    }()

    private let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    private lazy var stepperView: CustomStepper = {
        let stepper = CustomStepper()
        stepper.tintColor = .labelText
        stepper.addTarget(self, action: #selector(stepperChangedValueAction), for: .valueChanged)

        return stepper
    }()


    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()

        photoImage.image = nil
    }

    // MARK: - Configure

    func configure(with item: MenuModel, tag: Int) {
        nameLabel.text = item.name
        priceLabel.text = String(item.price) + " руб"
        setPhotoImage(url: item.imageURL)
        stepperView.tag = tag
    }

    // MARK: - Actions

    @objc
    private func stepperChangedValueAction(sender: CustomStepper) {
        stepperDelegate?.stepperWasChanged(tag: sender.tag, stepperValue: sender.currentValue)
    }

}

// MARK: - Private methods

fileprivate extension MenuCollectionViewCell {

    func setPhotoImage(url: String?, completionHandler: ((Bool) -> Void)? = nil) {
        guard let url, let url = URL(string: url) else {
            completionHandler?(false)
            return
        }

        let resource = KF.ImageResource(downloadURL: url)
        photoImage.kf.setImage(with: resource) { result in
            switch result {
            case .success:
                completionHandler?(true)
            case .failure:
                completionHandler?(false)
            }
        }
    }
}

// MARK: - Layout

extension MenuCollectionViewCell {

    override func setupSubviews() {
        super.setupSubviews()

        contentView.backgroundColor = .systemBackground
        shadowDecorate()
    }


    override func embedSubviews() {
        contentView.addSubviews(
            photoImage,
            nameLabel,
            priceLabel,
            stepperView)
    }

    override func setupConstraints() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        photoImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(photoImage.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(10)
        }

        stepperView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalTo(priceLabel.snp.height)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
}
