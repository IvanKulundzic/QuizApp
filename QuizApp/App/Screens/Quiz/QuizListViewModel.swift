import Foundation
import Resolver

final class QuizListViewModel {

    var categories: [CategoryViewModel] = [.sport, .movies, .music, .geography]
    @Published var quizes: [QuizViewModel] = []

    @Injected private var quizUseCase: QuizUseCaseProtocol
    @Injected private var coordinator: CoordinatorProtocol

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

    func goToQuizDetails(quiz: QuizViewModel) {
        coordinator.showQuizDetails(quiz: quiz)
    }

}
