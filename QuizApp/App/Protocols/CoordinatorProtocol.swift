import UIKit

protocol CoordinatorProtocol {

    func showLogin()

    func showHome()

    func showQuizDetails(quiz: QuizViewModel)

    func showQuizSession(quiz: QuizViewModel)

    func showLeaderboard()

    func close()

    func showQuizResult(viewModel: EndSessionViewModel)

    func popToRoot()

}
