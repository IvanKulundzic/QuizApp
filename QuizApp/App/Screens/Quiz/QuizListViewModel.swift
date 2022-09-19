import Foundation
import Combine
import Factory

final class QuizListViewModel {

    @Injected(Container.quizUseCase) private var quizUseCase
    @Injected(Container.coordinator) private var coordinator

    @Published var quizzes: [QuizViewModel] = []
    var categories: [CategoryViewModel] = [.all, .sport, .movies, .music, .geography]
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
