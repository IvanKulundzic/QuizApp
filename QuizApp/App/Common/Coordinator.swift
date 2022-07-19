import UIKit

final class Coordinator: CoordinatorProtocol {

    private let loginUseCase: LoginUseCaseProtocol
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.loginUseCase = LoginUseCase(networkClient: NetworkClient())
    }

    func showLogin() {
        startLoginFlow()
    }

}

// MARK: - Private methods
private extension Coordinator {

    func startLoginFlow() {
        let loginViewModel = LoginViewModel(loginUseCase: loginUseCase)
        let loginViewController = LoginViewController(loginViewModel: loginViewModel)
        navigationController.setViewControllers([loginViewController], animated: true)
    }

}
