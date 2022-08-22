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

    func fetchAllQuizes() {
        Task(priority: .background) {
            let quizes = try await quizUseCase.fetchQuizes()

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.quizes = quizes
                    .map { QuizViewModel(from: $0) }
                self.categories = quizes
                    .map { CategoryViewModel(from: $0.category) }
//                    .unique()
            }
        }
    }

    func fetchQuiz(for category: String) {
        Task(priority: .background) {
            let quizes = try await quizUseCase.fetchQuizes(for: category)

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.quizes = quizes
                    .map { QuizViewModel(from: $0) }
            }
        }
    }

    func fetchCategories() {
        Task(priority: .background) {
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
