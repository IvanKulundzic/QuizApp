import Foundation

final class QuizListViewModel {

    @Published var quizes: [QuizViewModel] = []

    private let quizUseCase: QuizUseCaseProtocol

    init(quizUseCase: QuizUseCaseProtocol) {
        self.quizUseCase = quizUseCase
    }

}

extension QuizListViewModel {

    func fetchQuiz() {
        Task(priority: .background) {
            let quizes = try await quizUseCase.fetchQuizes()

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.quizes = quizes
                    .map { QuizViewModel(from: $0) }
            }
        }
    }

}
