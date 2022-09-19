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
        let quizViewModel = QuizListViewModel(quizUseCase: serviceFactory.quizUseCase, coordinator: self)
        let quizViewController = QuizListViewController(quizViewModel: quizViewModel)
        let userViewModel = UserViewModel(userUseCase: serviceFactory.userUseCase)
        let userViewController = UserViewController(userViewModel: userViewModel)
        let viewControllers = [quizViewController, userViewController]
        let tabBarController = TabBarController(viewControllers: viewControllers)
        navigationController.setViewControllers([tabBarController], animated: true)
    }

    func showQuizDetails(quiz: QuizViewModel) {
        let viewModel = QuizDetailsViewModel(quiz: quiz, coordinator: self)
        let viewController = QuizDetailsViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = false
        navigationController.pushViewController(viewController, animated: true)
    }

    func showQuizSession() {
        let viewController = QuizSessionViewController()
        navigationController.pushViewController(viewController, animated: true)
    }

}
