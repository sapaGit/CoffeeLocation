//
//  MenuViewController.swift
//  CoffeeLocation
//

import UIKit
import SnapKit

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
        layout.itemSize = .init(width: 160, height: 210)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)

        return layout
    }()

    private lazy var menuCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.reuseIdentifier)

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

    override func embedSubviews() {

        view.addSubviews(menuCollectionView, openPaymentButton)
    }

    override func setupConstraints() {
        openPaymentButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }

        menuCollectionView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(7)
            $0.bottom.equalTo(openPaymentButton.snp.top).inset(-10)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MenuViewController: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDelegateFlowLayout

extension MenuViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: 150, height: 150)
//    }
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
