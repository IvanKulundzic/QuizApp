import Foundation

final class QuizListViewModel {

    @Published var categories: [CategoryViewModel] = []
    @Published var quizes: [QuizViewModel] = []

    private let quizUseCase: QuizUseCaseProtocol

    init(quizUseCase: QuizUseCaseProtocol) {
        self.quizUseCase = quizUseCase
    }

}

extension QuizListViewModel {

    func fetchQuiz(for category: String) {
        Task {
            let quizes = try await quizUseCase.fetchQuizes(for: category)

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                self.quizes = quizes
                    .map { QuizViewModel(from: $0) }
            }
        }
    }

    func fetchCategories() {
        Task {
            let quizes = try await quizUseCase.fetchQuizes()

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                self.categories = quizes
                    .map { CategoryViewModel(from: $0.category) }
                    .unique()
            }
        }
    }

}
