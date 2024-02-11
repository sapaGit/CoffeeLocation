//
//  RegistrationViewController.swift
//  CoffeeLocation
//

import UIKit
import SnapKit

private enum Constants {
    static let fontSize: CGFloat = 15.0
    static let stackViewSpacing: CGFloat = 40.0
    static let stackViewCustomSpacing: CGFloat = 4.0
    static let stackViewInset: CGFloat = 20.0
}

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
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.text = String.Registration.email

        return label
    }()

    private let loginTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = String.Registration.insertEmail

        return textField
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelText
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.text = String.Registration.password

        return label
    }()

    private let passwordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = String.Registration.insertPassword
        textField.isSecureTextEntry = true

        return textField
    }()

    private let repeatPasswordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelText
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.text = String.Registration.repeatPassword

        return label
    }()

    private let repeatPasswordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = String.Registration.password
        textField.isSecureTextEntry = true

        return textField
    }()

    private lazy var registerButton: BaseButton = {
        let button = BaseButton()
        button.setTitle(String.Registration.title, for: .normal)
        button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)

        return button
    }()

    private let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing

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
            showAlert(message: String.Registration.insertCorrectLogin)
            return
        }
        guard passwordTextField.text == repeatPasswordTextField.text else {
            showAlert(message: String.Registration.passwordMissmatch)
            return
        }
        presenter.didTapRegister(login: login, password: password)
    }

    private func showAlert(message: String) {
        let alertController = UIAlertController(
            title: String.Registration.loginError,
            message: message,
            preferredStyle: .alert
        )
        let closeAction = UIAlertAction(title: String.Registration.closeTitle, style: .default, handler: nil)
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

    override func setupSubviews() {
        super.setupSubviews()

        title = String.Registration.title
    }

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
        
        verticalStack.setCustomSpacing(Constants.stackViewCustomSpacing, after: loginLabel)
        verticalStack.setCustomSpacing(Constants.stackViewCustomSpacing, after: passwordLabel)
        verticalStack.setCustomSpacing(Constants.stackViewCustomSpacing, after: repeatPasswordLabel)
    }

    override func setupConstraints() {

        verticalStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.stackViewInset)
            $0.centerY.equalToSuperview()
        }
    }
}
