import UIKit

final class LoginCoordinator: Coordinator {

    private var navigationController: UINavigationController?

    func start() -> UIViewController {
        showLoginScreen()
    }

}

// MARK: - Private methods
private extension LoginCoordinator {

    func showLoginScreen() -> UIViewController {
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        navigationController.pushViewController(loginViewController, animated: true)
        return navigationController
    }

}
