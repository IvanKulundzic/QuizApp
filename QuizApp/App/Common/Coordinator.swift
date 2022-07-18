import UIKit

final class Coordinator: CoordinatorProtocol {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogin() {
        startLoginFlow()
    }

}

// MARK: - Private methods
private extension Coordinator {

    func startLoginFlow() {
        let loginViewController = LoginViewController()
        navigationController.setViewControllers([loginViewController], animated: true)
    }

}
