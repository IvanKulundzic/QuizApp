import Foundation
import Combine

final class QuizListViewModel {


    var categories: [CategoryViewModel] = [.sport, .movies, .music, .geography]
    @Published var quizes: [QuizViewModel] = []
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
            } catch {
                hideEmptyStateView = false
                completion()
            }
        }
    }

    func fetchAllQuizes(completion: @escaping () -> Void) {
        Task {
            do {
                let quizes = try await quizUseCase.fetchQuizes()

                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }

                    self.quizes = quizes
                        .map { QuizViewModel(from: $0) }
                    self.hideEmptyStateView = true
                }
            } catch {
                hideEmptyStateView = false

                self.quizzes = quizes
                    .map { QuizViewModel(from: $0) }
                completion()
            }

        }
    }

    @MainActor
    func fetchInitialQuiz() {
        let firstCategory = CategoryModel(from: categories.first ?? .sport)
        fetchQuiz(for: firstCategory)
    }
    
    func goToQuizDetails(quiz: QuizViewModel) {
        coordinator.showQuizDetails(quiz: quiz)
    }

}
