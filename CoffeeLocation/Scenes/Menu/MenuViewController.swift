//
//  MenuViewController.swift
//  CoffeeLocation
//

import UIKit
import SnapKit

private enum Constants {
    static let layoutInterSpacing: CGFloat = 10.0
    static let itemHeightMultiplier: CGFloat = 1.3
    static let paymentButtonInset: CGFloat = 20.0
    static let collectionViewInset: CGFloat = 7
}

protocol MenuViewProtocol: AnyObject {
    /// Notifies that new data has been received.
    func didReceiveData()

    func showAlert(title: String, message: String)

    /// Navigates to ViewController
    func pushViewController(_ viewController: UIViewController, animated: Bool)
}

final class MenuViewController: BaseViewController {

    // MARK: - Properties

    private let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.layoutInterSpacing*2
        layout.minimumInteritemSpacing = Constants.layoutInterSpacing
        layout.sectionInset = .init(
            top: Constants.layoutInterSpacing,
            left: Constants.layoutInterSpacing,
            bottom: Constants.layoutInterSpacing,
            right: Constants.layoutInterSpacing)

        return layout
    }()

    private lazy var menuCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(
            MenuCollectionViewCell.self,
            forCellWithReuseIdentifier: MenuCollectionViewCell.reuseIdentifier
        )

        return collectionView
    }()

    private lazy var openPaymentButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Перейти к оплате", for: .normal)
        button.addTarget(self, action: #selector(didTapOpenPayment), for: .touchUpInside)

        return button
    }()

    // MARK: - Dependencies

    var presenter: MenuPresenterProtocol!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        presenter.viewDidLoad()
    }

    // MARK: - Private methods

    @objc
    private func didTapOpenPayment() {
        presenter.didTapOpenPayment()
    }
}

// MARK: - MenuViewProtocol

extension MenuViewController: MenuViewProtocol {

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let closeAction = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
        alertController.addAction(closeAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func didReceiveData() {
        menuCollectionView.reloadData()
    }
}

// MARK: - SetupSubviews

extension MenuViewController {

    override func setupSubviews() {
        super.setupSubviews()

        title = "Меню"
    }

    override func embedSubviews() {

        view.addSubviews(menuCollectionView, openPaymentButton)
    }

    override func setupConstraints() {
        openPaymentButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.paymentButtonInset)
            $0.bottom
                .equalTo(view.safeAreaLayoutGuide.snp.bottom)
                .inset(Constants.paymentButtonInset)
        }

        menuCollectionView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(Constants.collectionViewInset)
            $0.bottom.equalTo(openPaymentButton.snp.top).inset(-Constants.collectionViewInset)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MenuViewController: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDelegateFlowLayout

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.size.width/2-Constants.layoutInterSpacing*2
        let itemHeight = Constants.itemHeightMultiplier * itemWidth
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

// MARK: - UICollectionViewDataSource

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.menuArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.reuseIdentifier, for: indexPath) as? MenuCollectionViewCell else { fatalError("Can't dequeue reusable cell")}
        let currentModel = presenter.menuArray[indexPath.row]
        cell.configure(with: currentModel, tag: indexPath.row)
        cell.stepperDelegate = self

        return cell
    }
}

// MARK: - StepperValueChangedDelegate

extension MenuViewController: StepperWasChangedDelegate {
    func stepperWasChanged(tag: Int, stepperValue: Int) {
        presenter.changeOrder(id: tag, amount: stepperValue)
    }
}
