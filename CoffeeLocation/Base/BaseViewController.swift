//
//  BaseViewController.swift
//  CoffeeLocation
//


import UIKit

class BaseViewController: UIViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        updateSubviews()
        updateConstraints()
    }
}

// MARK: - UINavigationController

extension BaseViewController {

    /// Sets the color of the navigation bar.
    ///
    /// - Parameter color: The tint color for the navigation bar.
    func setupNavigationBar(color: UIColor = .labelText) {
        navigationController?.navigationBar.tintColor = color
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
        navigationItem.backButtonDisplayMode = .minimal
    }

    /// Sets the visibility of the navigation bar.
    ///
    /// - Parameters:
    ///   - hidden: A flag determining whether the navigation bar should be hidden.
    ///   - animated: A flag determining whether to animate the visibility change.
    func setupNavigationBar(hidden: Bool, animated: Bool = true) {
        navigationController?.setNavigationBarHidden(hidden, animated: animated)
    }

    /// Pushes a view controller onto the navigation stack with an option for animation.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to push onto the stack.
    ///   - animated: A flag determining whether to animate the transition.
    func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    /// Pops the top view controller from the navigation stack with an option for animation.
    ///
    /// - Parameter animated: A flag determining whether to animate the transition.
    func popViewController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }

    /// Pops all the view controllers from the navigation stack except the root view controller.`.
    ///
    /// - Parameter animated: A flag determining whether to animate the transition.
    func popToRoot(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }

    /// Presents a view controller modally with a specified presentation style and animation option.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to present.
    ///   - presentationStyle: The presentation style for the modal view controller.
    ///   - animated: A flag determining whether to animate the presentation.
    ///   - completionHandler: A closure to be executed after the presentation finishes.
    func presentViewController(_ viewController: UIViewController, presentationStyle: UIModalPresentationStyle = .fullScreen, animated: Bool = true, completionHandler: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = presentationStyle
        present(viewController, animated: animated, completion: completionHandler)
    }

    /// Dismisses the current view controller modally presented with an option for animation.
    ///
    /// - Parameter animated: A flag determining whether to animate the dismissal.
    func dismissViewController(animated: Bool = true) {
        dismiss(animated: animated)
    }
}

// MARK: - Setup Subviews

@objc extension BaseViewController {

    /// Configures the subviews of the controller.
    func setupSubviews() {
        view.backgroundColor = .systemBackground

        setupNavigationBar()

        embedSubviews()
        setupConstraints()
    }

    /// Embeds subviews into the controller's view.
    func embedSubviews() {}

    /// Sets up constraints for the controller's subviews.
    func setupConstraints() {}

    /// Updates the controller's subviews.
    func updateSubviews() {}

    /// Updates constraints for the controller's subviews.
    func updateConstraints() {}
}
