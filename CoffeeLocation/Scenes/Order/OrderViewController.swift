//
//  OrderViewController.swift
//  CoffeeLocation
//

import UIKit
import SnapKit

protocol OrderViewProtocol: AnyObject {
    /// Notifies that new data has been received.
    func didReceiveData()

    func showAlert(title: String, message: String)

    /// Navigates to ViewController
    func pushViewController(_ viewController: UIViewController, animated: Bool)
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
        label.numberOfLines = 0
        label.textColor = .labelText
        label.text = "Время ожидания заказа 15 минут!\n Спасибо, что выбрали нас!"
        label.font = .systemFont(ofSize: 22, weight: .semibold)

        return label
    }()

    private lazy var payButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Оплатить", for: .normal)
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
        let closeAction = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
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

        title = "Ваш заказ"
    }

    override func embedSubviews() {

        view.addSubviews(
            orderTableView,
            infoLabel,
            payButton)
    }

    override func setupConstraints() {
        payButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }

        infoLabel.snp.makeConstraints {
            $0.bottom.equalTo(payButton.snp.top).inset(-100)
            $0.leading.trailing.equalToSuperview().inset(30)
        }

        orderTableView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(7)
            $0.bottom.equalTo(infoLabel.snp.top).inset(50)
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

