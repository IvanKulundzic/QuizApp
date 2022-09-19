import Foundation
import Combine

final class QuizListViewModel {

    var categories: [CategoryViewModel] = [.all, .sport, .movies, .music, .geography]
    @Published var quizzes: [QuizViewModel] = []

    private let quizUseCase: QuizUseCaseProtocol
    private let coordinator: CoordinatorProtocol

    init(quizUseCase: QuizUseCaseProtocol, coordinator: CoordinatorProtocol) {
        self.quizUseCase = quizUseCase
        self.coordinator = coordinator
    }

}

extension QuizListViewModel {

    func fetchQuiz(for category: CategoryModel, completion: @escaping () -> Void) {
        Task {
            let quizes = try await quizUseCase.fetchQuizes(for: category)

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                self.quizzes = quizes
                    .map { QuizViewModel(from: $0) }
                completion()
            }
        }
    }

    func fetchAllQuizes(completion: @escaping () -> Void) {
        Task {
            let quizes = try await quizUseCase.fetchQuizes()

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                self.quizzes = quizes
                    .map { QuizViewModel(from: $0) }
                completion()
            }
        }
    }

    func goToQuizDetails(quiz: QuizViewModel) {
        coordinator.showQuizDetails(quiz: quiz)
    }

}
