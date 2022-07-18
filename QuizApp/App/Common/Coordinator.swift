import UIKit

final class Coordinator: CoordinatorProtocol {

    private let loginService: LoginServiceProtocol
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.loginService = LoginService(networkService: NetworkService())
    }

    func showLogin() {
        startLoginFlow()
    }

}

// MARK: - Private methods
private extension Coordinator {

    func startLoginFlow() {
        let loginViewModel = LoginViewModel(loginService: loginService)
        let loginViewController = LoginViewController(loginViewModel: loginViewModel)
        navigationController.setViewControllers([loginViewController], animated: true)
    }

}
