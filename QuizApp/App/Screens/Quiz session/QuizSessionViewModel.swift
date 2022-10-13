import Foundation

final class QuizSessionViewModel {

    var quiz: QuizViewModel
    var questions: [QuestionViewModel] = []
    private let quizUseCase: QuizUseCaseProtocol
    private let coordinator: CoordinatorProtocol

    init(quiz: QuizViewModel, quizUseCase: QuizUseCaseProtocol, coordinator: CoordinatorProtocol) {
        self.quiz = quiz
        self.quizUseCase = quizUseCase
        self.coordinator = coordinator
    }

    func getQuestions() async {
        do {
            questions = try await quizUseCase.getQuestions(for: quiz.id)
                .map { QuestionViewModel(from: $0) }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func goToQuizResult() {
        coordinator.showQuizResult()
    }

}
