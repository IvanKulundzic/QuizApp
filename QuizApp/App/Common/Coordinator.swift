import UIKit

final class Coordinator: CoordinatorProtocol {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogin() -> UIViewController {
        startLoginFlow()
    }

}

// MARK: - Private methods
private extension Coordinator {

    func startLoginFlow() -> UIViewController {
        let loginViewController = LoginViewController()
        navigationController.pushViewController(loginViewController, animated: true)
        return navigationController
    }

}
