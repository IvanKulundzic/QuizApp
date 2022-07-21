import UIKit

final class Coordinator: CoordinatorProtocol {

    private let navigationController: UINavigationController
    private let serviceFactory: ServiceFactoryProtocol

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.serviceFactory = ServiceFactory()
    }

    func showLogin() {
        let loginViewModel = LoginViewModel(loginUseCase: serviceFactory.loginUseCase, coordinator: self)
        let loginViewController = LoginViewController(loginViewModel: loginViewModel)
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func showHome() {
        let quizViewController = QuizViewController()
        let viewControllers = [quizViewController]
        let tabBarController = TabBarController(viewControllers: viewControllers)
        navigationController.setViewControllers([tabBarController], animated: true)
    }

}
