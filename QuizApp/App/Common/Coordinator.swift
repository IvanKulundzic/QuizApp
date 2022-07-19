import UIKit

final class Coordinator: CoordinatorProtocol {

    private let navigationController: UINavigationController
    private let serviceFactory: ServiceFactoryProtocol

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.serviceFactory = ServiceFactory()
    }

    func showLogin() {
        startLoginFlow()
    }

}

// MARK: - Private methods
private extension Coordinator {

    func startLoginFlow() {
        let loginViewModel = LoginViewModel(loginUseCase: serviceFactory.loginUseCase)
        let loginViewController = LoginViewController(loginViewModel: loginViewModel)
        navigationController.setViewControllers([loginViewController], animated: true)
    }

}
