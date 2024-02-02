//
//  LoginViewController.swift
//  CoffeeLocation
//


import UIKit
import SnapKit

protocol LoginViewProtocol: AnyObject {
    /// Notifies that new data has been received.
    func didReceiveData()

    /// Navigates to ViewController
    func pushViewController(_ viewController: UIViewController, animated: Bool)
}

final class LoginViewController: BaseViewController {

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

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .buttonBackground
        button.tintColor = .buttonText
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        button.layer.cornerRadius = 22

        return button
    }()

    private let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40

        return stackView
    }()

    // MARK: - Dependencies

    var presenter: LoginPresenterProtocol!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    // MARK: - Private methods

    @objc
    private func didTapLogin() {
        guard let login = loginTextField.text, let password = passwordTextField.text, !login.isEmpty, !password.isEmpty else {
            showAlert()
            return
        }
        presenter.didTapLogin(login: login, password: password)
    }

    private func showAlert() {
        let alertController = UIAlertController(
            title: "Ошибка входа",
            message: "Введите корректный логин и пароль",
            preferredStyle: .alert
        )
        let closeAction = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
        alertController.addAction(closeAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - LoginViewProtocol

extension LoginViewController: LoginViewProtocol {
    func didReceiveData() {
    }
}

// MARK: - SetupSubviews

extension LoginViewController {
    override func embedSubviews() {
        verticalStack.addArrangedSubviews(
            loginLabel,
            loginTextField,
            passwordLabel,
            passwordTextField,
            loginButton
        )

        view.addSubview(verticalStack)
        verticalStack.setCustomSpacing(4, after: loginLabel)
        verticalStack.setCustomSpacing(4, after: passwordLabel)
    }

    override func setupConstraints() {
        loginButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }

        verticalStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
}

