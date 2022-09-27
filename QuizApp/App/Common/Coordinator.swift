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
        let viewModel = QuizDetailsContainer.quizDetailsViewModel(quiz)
        let viewController = QuizDetailsContainer.quizDetailsViewController(viewModel)
        viewController.hidesBottomBarWhenPushed = false
        navigationController.pushViewController(viewController, animated: true)
    }

}
