import Foundation

final class QuizSessionViewModel {

    var quiz: QuizViewModel
    var questions: [QuestionViewModel] = []
    private let quizUseCase: QuizUseCaseProtocol

    init(quiz: QuizViewModel, quizUseCase: QuizUseCaseProtocol) {
        self.quiz = quiz
        self.quizUseCase = quizUseCase
    }

    func startQuizSession(completion: @escaping EmpytCallback) {
        Task {
            do {
                questions = try await quizUseCase.startQuizSession(for: quiz.id)
                    .map { QuestionViewModel(from: $0) }
                completion()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

}
