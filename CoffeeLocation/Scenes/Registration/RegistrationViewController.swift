//
//  RegistrationViewController.swift
//  CoffeeLocation
//


import UIKit
import SnapKit

protocol RegistrationViewProtocol: AnyObject {
    /// Notifies that new data has been received.
    func didReceiveData()

    /// Navigates to ViewController
    func pushViewController(_ viewController: UIViewController, animated: Bool)
}

final class RegistrationViewController: BaseViewController {

    // MARK: - Properties

    private let loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelText
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "e-mail"

        return label
    }()

    private let loginTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Введите email"

        return textField
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelText
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Пароль"

        return label
    }()

    private let passwordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Введите пароль"
        textField.isSecureTextEntry = true

        return textField
    }()

    private let repeatPasswordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelText
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Повторите пароль"

        return label
    }()

    private let repeatPasswordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Пароль"
        textField.isSecureTextEntry = true

        return textField
    }()

    private lazy var registerButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Регистрация", for: .normal)
        button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)

        return button
    }()

    private let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40

        return stackView
    }()

    // MARK: - Dependencies

    var presenter: RegistrationPresenterProtocol!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    // MARK: - Private methods

    @objc
    private func didTapRegister() {
        guard let login = loginTextField.text, let password = passwordTextField.text, !login.isEmpty, !password.isEmpty else {
            showAlert(message: "Введите корректний логин и пароль")
            return
        }
        guard passwordTextField.text == repeatPasswordTextField.text else {
            showAlert(message: "Пароли не совпадают")
            return
        }
        presenter.didTapRegister(login: login, password: password)
    }

    private func showAlert(message: String) {
        let alertController = UIAlertController(
            title: "Ошибка входа",
            message: message,
            preferredStyle: .alert
        )
        let closeAction = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
        alertController.addAction(closeAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - LoginViewProtocol

extension RegistrationViewController: RegistrationViewProtocol {
    func didReceiveData() {
    }
}

// MARK: - SetupSubviews

extension RegistrationViewController {
    override func embedSubviews() {
        verticalStack.addArrangedSubviews(
            loginLabel,
            loginTextField,
            passwordLabel,
            passwordTextField,
            repeatPasswordLabel,
            repeatPasswordTextField,
            registerButton
        )

        view.addSubview(verticalStack)
        verticalStack.setCustomSpacing(4, after: loginLabel)
        verticalStack.setCustomSpacing(4, after: passwordLabel)
        verticalStack.setCustomSpacing(4, after: repeatPasswordLabel)
    }

    override func setupConstraints() {

        verticalStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
}
