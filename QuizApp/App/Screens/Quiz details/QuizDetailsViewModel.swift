import UIKit
import Factory

final class QuizDetailsViewModel {

    @Published var quiz: QuizViewModel
    @Injected(Container.coordinator) private var coordinator

    init(quiz: QuizViewModel) {
        self.quiz = quiz
    }

    func startQuiz(quiz: QuizViewModel) {
        coordinator.showQuizSession(quiz: quiz)
    }

}
