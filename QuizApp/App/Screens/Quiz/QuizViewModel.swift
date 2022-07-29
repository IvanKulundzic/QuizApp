import Foundation

final class QuizViewModel {

    @Published var quizes: [QuizModel] = []

    private let quizUseCase: QuizUseCaseProtocol

    init(quizUseCase: QuizUseCaseProtocol) {
        self.quizUseCase = quizUseCase
    }

}

extension QuizViewModel {

    func fetchQuiz() {
        Task(priority: .background) {
            quizes = try await quizUseCase.fetchQuizes(for: .sport)
            quizes = quizes
        }

    }

}
