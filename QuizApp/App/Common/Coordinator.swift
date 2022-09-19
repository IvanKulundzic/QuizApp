import UIKit
import Factory

final class Coordinator: CoordinatorProtocol {

    @Injected(Container.navigationController) private var navigationController
    @Injected(QuizContainer.quizUseCase) private var quizUseCase
    @Injected(UserContainer.userUseCase) private var userUseCase

    func showLogin() {
        let loginViewController = LoginViewController()
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func showHome() {
        let quizViewController = QuizListViewController()
        let userViewController = UserViewController()
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
