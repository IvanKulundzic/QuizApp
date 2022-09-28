import Foundation
import Combine
import Factory

final class QuizListViewModel {

    var categories: [CategoryViewModel] = [.all, .sport, .movies, .music, .geography]
    @Published var quizzes: [QuizViewModel] = []
    @Published var hideEmptyStateView: Bool = true
    private let quizUseCase: QuizUseCaseProtocol
    private let coordinator: CoordinatorProtocol

    init(quizUseCase: QuizUseCaseProtocol, coordinator: CoordinatorProtocol) {
        self.quizUseCase = quizUseCase
        self.coordinator = coordinator
    }

}

extension QuizListViewModel {

    @MainActor
    func fetchQuiz(for category: CategoryModel, completion: @escaping () -> Void) {
        Task {
            do {
                let quizes = try await quizUseCase.fetchQuizes(for: category)

                self.quizzes = quizes
                    .map { QuizViewModel(from: $0) }
                hideEmptyStateView = true
                completion()
            } catch {
                hideEmptyStateView = false
            }
        }
    }

    func fetchAllQuizes(completion: @escaping () -> Void) {
        Task {
            do {
                let quizes = try await quizUseCase.fetchQuizes()

                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }

                    self.quizzes = quizes
                        .map { QuizViewModel(from: $0) }
                    self.hideEmptyStateView = true
                }
            } catch {
                hideEmptyStateView = false
            }
        }
    }

    func goToQuizDetails(quiz: QuizViewModel) {
        coordinator.showQuizDetails(quiz: quiz)
    }

}
