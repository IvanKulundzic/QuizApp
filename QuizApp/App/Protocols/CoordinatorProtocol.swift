import UIKit

protocol CoordinatorProtocol {

    func showLogin()

    func showHome()

    func showQuizDetails(quiz: QuizViewModel)

    func showQuizSession()
}
