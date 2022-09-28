import UIKit
import Factory

final class Coordinator: CoordinatorProtocol {

    @Injected(Container.navigationController) private var navigationController

    func showLogin() {
        let loginViewController = LoginContainer.loginViewController()
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func showHome() {
        let quizViewController = QuizContainer.quizListViewController()
        let userViewController = UserContainer.userViewController()
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

    func showQuizSession(quiz: QuizViewModel) {
        let viewModel = QuizSessionViewModel(quiz: quiz)
        let viewController = QuizSessionViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

}
