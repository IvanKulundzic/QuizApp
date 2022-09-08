import UIKit
import Resolver

final class Coordinator: CoordinatorProtocol {

    @Injected private var navigationController: UINavigationController

    func showLogin() {
        let loginViewModel = LoginViewModel()
        let loginViewController = LoginViewController(loginViewModel: loginViewModel)
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func showHome() {
        let quizViewModel = QuizListViewModel()
        let quizViewController = QuizListViewController(quizViewModel: quizViewModel)
        let userViewModel = UserViewModel()
        let userViewController = UserViewController(userViewModel: userViewModel)
        let viewControllers = [quizViewController, userViewController]
        let tabBarController = TabBarController(viewControllers: viewControllers)
        navigationController.setViewControllers([tabBarController], animated: true)
    }

    func showQuizDetails(quiz: QuizViewModel) {
        let viewModel = QuizDetailsViewModel(quiz: quiz)
        let viewController = QuizDetailsViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = false
        navigationController.pushViewController(viewController, animated: true)
    }

}
