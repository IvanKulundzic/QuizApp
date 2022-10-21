import Foundation

final class QuizSessionViewModel {

    var quiz: QuizViewModel
    var questions: [QuestionViewModel] = []
    var sessionId: String = ""
    private let quizUseCase: QuizUseCaseProtocol
    private let coordinator: CoordinatorProtocol

    init(quiz: QuizViewModel, quizUseCase: QuizUseCaseProtocol, coordinator: CoordinatorProtocol) {
        self.quiz = quiz
        self.quizUseCase = quizUseCase
        self.coordinator = coordinator
    }

    func getQuestions() async {
        do {
            let session = try await quizUseCase.getQuestions(for: quiz.id)
            questions = session.0
                .map { QuestionViewModel(from: $0) }
            sessionId = session.1
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func goToQuizResult(viewModel: EndSessionViewModel) {
        coordinator.showQuizResult(viewModel: viewModel)
    }

}
