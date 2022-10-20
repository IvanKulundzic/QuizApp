import Foundation
import Factory

protocol QuizUseCaseProtocol {

    func fetchQuizes() async throws -> [QuizModel]

    func fetchQuizes(for category: CategoryModel) async throws -> [QuizModel]

    func getQuestions(for quizId: Int) async throws -> [QuestionModel]

}

final class QuizUseCase: QuizUseCaseProtocol {

    private let quizRepository: QuizRepositoryProtocol

    init(quizRepository: QuizRepositoryProtocol) {
        self.quizRepository = quizRepository
    }

    func fetchQuizes() async throws -> [QuizModel] {
        await quizRepository.fetchQuizzes()
            .map { QuizModel(from: $0) }
    }

    func fetchQuizes(for category: CategoryModel) async throws -> [QuizModel] {
        await quizRepository.fetchQuizzes(for: category)
            .map { QuizModel(from: $0) }
    }

    func getQuestions(for quizId: Int) async throws -> [QuestionModel] {
        await quizRepository.getQuestions(for: quizId)
            .map { QuestionModel(from: $0) }
    }

}
