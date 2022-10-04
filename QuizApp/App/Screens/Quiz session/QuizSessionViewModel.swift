import Foundation

final class QuizSessionViewModel {

    var quiz: QuizViewModel
    var questions: [QuestionViewModel] = []
    private let quizUseCase: QuizUseCaseProtocol

    init(quiz: QuizViewModel, quizUseCase: QuizUseCaseProtocol) {
        self.quiz = quiz
        self.quizUseCase = quizUseCase
    }

    func getQuestions() async {
        do {
            questions = try await quizUseCase.getQuestions(for: quiz.id)
                .map { QuestionViewModel(from: $0) }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

}
