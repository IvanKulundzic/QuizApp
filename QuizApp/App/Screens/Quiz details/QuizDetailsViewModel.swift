import UIKit
import Factory

final class QuizDetailsViewModel {

    @Published var quiz: QuizViewModel
    private var coordinator: CoordinatorProtocol

    init(quiz: QuizViewModel, coordinator: CoordinatorProtocol) {
        self.quiz = quiz
        self.coordinator = coordinator
    }

    func startQuiz(quiz: QuizViewModel) {
        coordinator.showQuizSession(quiz: quiz)
    }

    func goToLeaderboard() {
        coordinator.showLeaderboard()
    }

}
