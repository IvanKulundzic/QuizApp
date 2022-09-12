import Foundation

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
    func fetchQuiz(for category: CategoryModel) {
        Task {
            do {
                let quizes = try await quizUseCase.fetchQuizes(for: category)

                self.quizes = quizes
                    .map { QuizViewModel(from: $0) }

            } catch {
                hideEmptyStateView = false
            }
        }
    }

    func fetchAllQuizes() throws {
        Task {
            do {
                let quizes = try await quizUseCase.fetchQuizes()

                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }

                    self.quizes = quizes
                        .map { QuizViewModel(from: $0) }
                }
            } catch {
                hideEmptyStateView = false
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
