import Foundation

final class QuizListViewModel {

    var categories: [CategoryViewModel] = [.sport, .movies, .music, .geography]
    @Published var quizes: [QuizViewModel] = []

    private let quizUseCase: QuizUseCaseProtocol

    init(quizUseCase: QuizUseCaseProtocol) {
        self.quizUseCase = quizUseCase
    }

}

extension QuizListViewModel {

    func fetchQuiz(for category: CategoryModel) {
        Task {
            let quizes = try await quizUseCase.fetchQuizes(for: category)

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                self.quizes = quizes
                    .map { QuizViewModel(from: $0) }
            }
        }
    }

    func fetchAllQuizes() {
        Task {
            let quizes = try await quizUseCase.fetchQuizes()

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                self.quizes = quizes
                    .map { QuizViewModel(from: $0) }
            }
        }
    }

    func fetchInitialQuiz() {
        let firstCategory = CategoryModel(from: categories.first ?? .sport)
        fetchQuiz(for: firstCategory)
    }

}
