import UIKit

final class QuizDetailsViewModel {

    @Published var quiz: QuizViewModel
    private let coordinator: CoordinatorProtocol

    init(quiz: QuizViewModel, coordinator: CoordinatorProtocol) {
        self.quiz = quiz
        self.coordinator = coordinator
    }

    func startQuiz() {
        coordinator.showQuizSession()
    }

}
