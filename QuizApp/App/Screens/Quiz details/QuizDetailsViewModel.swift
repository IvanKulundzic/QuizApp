import UIKit

final class QuizDetailsViewModel {

    @Published var quiz: QuizViewModel

    init(quiz: QuizViewModel) {
        self.quiz = quiz
    }

}
