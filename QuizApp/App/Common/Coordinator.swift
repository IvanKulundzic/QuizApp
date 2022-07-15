import UIKit

final class Coordinator: CoordinatorProtocol {

    private var navigationController: UINavigationController?

    func start() -> UIViewController {
        startLoginFlow()
    }

}

// MARK: - Private methods
private extension Coordinator {

    func startLoginFlow() -> UIViewController {
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        navigationController.pushViewController(loginViewController, animated: true)
        return navigationController
    }

}
