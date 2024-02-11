//
//  LoginViewController.swift
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
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.text = String.Login.email

        return label
    }()

    private let loginTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = String.Login.insertEmail

        return textField
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelText
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.text = String.Login.password

        return label
    }()

    private let passwordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = String.Login.insertPassword
        textField.isSecureTextEntry = true

        return textField
    }()

    private lazy var loginButton: BaseButton = {
        let button = BaseButton()
        button.setTitle(String.Login.buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)

        return button
    }()

    private let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing

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
            title: String.Login.loginError,
            message: String.Login.insertCorrectLogin,
            preferredStyle: .alert
        )
        let closeAction = UIAlertAction(title: String.Login.closeTitle, style: .default, handler: nil)
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

    override func setupSubviews() {
        super.setupSubviews()

        title = String.Login.title
    }

    override func embedSubviews() {
        verticalStack.addArrangedSubviews(
            loginLabel,
            loginTextField,
            passwordLabel,
            passwordTextField,
            loginButton
        )

        view.addSubview(verticalStack)
        verticalStack.setCustomSpacing(Constants.stackViewCustomSpacing, after: loginLabel)
        verticalStack.setCustomSpacing(Constants.stackViewCustomSpacing, after: passwordLabel)
    }

    override func setupConstraints() {

        verticalStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.stackViewInset)
            $0.centerY.equalToSuperview()
        }
    }
}

