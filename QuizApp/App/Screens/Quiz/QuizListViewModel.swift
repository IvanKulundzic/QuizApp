import Foundation
import Combine
import Factory

final class QuizListViewModel {

    @Injected(QuizContainer.quizUseCase) private var quizUseCase
    @Injected(Container.coordinator) private var coordinator
    @Published var quizzes: [QuizViewModel] = []
    @Published var hideEmptyStateView: Bool = true
    var categories: [CategoryViewModel] = [.all, .sport, .movies, .music, .geography]

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
