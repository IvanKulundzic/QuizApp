import Foundation

final class QuizResultViewModel {

    private let quizUseCase: QuizUseCaseProtocol
    private let coordinator: CoordinatorProtocol

    init(quizUseCase: QuizUseCaseProtocol, coordinator: CoordinatorProtocol) {
        self.quizUseCase = quizUseCase
        self.coordinator = coordinator
    }

    func endQuizSession(for id: String, correctQuestions: Int) {
        Task {
            try await quizUseCase.endQuizSession(for: id, correctQuestions: correctQuestions)
        }
        coordinator.popToRoot()
    }

}
