//
//  OrderViewController.swift
//  CoffeeLocation
//

import UIKit
import SnapKit

private enum Constants {
    static let payButtonInset: CGFloat = 20.0
    static let infoLabelBottomInset: CGFloat = 100.0
    static let infoLabelInset: CGFloat = 20.0
    static let tableViewInset: CGFloat = 7.0
    static let infoLabelFontSize: CGFloat = 22.0
}

protocol OrderViewProtocol: AnyObject {
    /// Notifies that new data has been received.
    func didReceiveData()
    func showAlert(title: String, message: String)
}

final class OrderViewController: BaseViewController {

    // MARK: - Properties

    private lazy var orderTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.register(
            OrderTableViewCell.self,
            forCellReuseIdentifier: OrderTableViewCell.reuseIdentifier
        )

        return tableView
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.textColor = .labelText
        label.text = String.Order.infoMessage
        label.font = .systemFont(ofSize: Constants.infoLabelFontSize, weight: .semibold)

        return label
    }()

    private lazy var payButton: BaseButton = {
        let button = BaseButton()
        button.setTitle(String.Order.pay, for: .normal)
        button.addTarget(self, action: #selector(didTapPayButton), for: .touchUpInside)

        return button
    }()

    // MARK: - Dependencies

    var presenter: OrderPresenterProtocol!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        presenter.viewDidLoad()
    }

    // MARK: - Private methods

    @objc
    private func didTapPayButton() {
        presenter.didTapPayButton()
    }
}

// MARK: - LoginViewProtocol

extension OrderViewController: OrderViewProtocol {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let closeAction = UIAlertAction(title: String.Order.closeTitle, style: .default, handler: nil)
        alertController.addAction(closeAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func didReceiveData() {
        orderTableView.reloadData()
    }
}

// MARK: - SetupSubviews

extension OrderViewController {

    override func setupSubviews() {
        super.setupSubviews()

        title = String.Order.title
    }

    override func embedSubviews() {

        view.addSubviews(
            orderTableView,
            infoLabel,
            payButton)
    }

    override func setupConstraints() {
        payButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.payButtonInset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Constants.payButtonInset)
        }

        infoLabel.snp.makeConstraints {
            $0.bottom.equalTo(payButton.snp.top).inset(-Constants.infoLabelBottomInset)
            $0.leading.trailing.equalToSuperview().inset(Constants.infoLabelInset)
        }

        orderTableView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(Constants.tableViewInset)
            $0.bottom.equalTo(infoLabel.snp.top).inset(-Constants.tableViewInset)
        }
    }
}

// MARK: - UITableViewDelegate

extension OrderViewController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource

extension OrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.order.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let currentModel = presenter.order[indexPath.row]
        cell.configure(model: currentModel, index: indexPath.row)
        cell.stepperDelegate = self

        return cell
    }
}

// MARK: - StepperValueChangedDelegate

extension OrderViewController: StepperWasChangedDelegate {
    func stepperWasChanged(tag: Int, stepperValue: Int) {
        presenter.changeOrder(id: tag, amount: stepperValue)
    }
}

