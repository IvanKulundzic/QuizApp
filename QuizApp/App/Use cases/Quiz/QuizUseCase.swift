import Foundation
import Factory

struct QuizQuestionModel {

    let sessionId: String
    let questions: [QuestionModel]

}

protocol QuizUseCaseProtocol {

    func fetchQuizes() async throws -> [QuizModel]

    func fetchQuizes(for category: CategoryModel) async throws -> [QuizModel]

    func getQuestions(for quizId: Int) async throws -> QuizQuestionModel

    func endQuizSession(for id: String, correctQuestions: Int) async throws

}

final class QuizUseCase: QuizUseCaseProtocol {

    private let quizNetworkDataSource: QuizNetworkDataSourceProtocol

    init(quizNetworkDataSource: QuizNetworkDataSourceProtocol) {
        self.quizNetworkDataSource = quizNetworkDataSource
    }

    func fetchQuizes() async throws -> [QuizModel] {
        return try await quizNetworkDataSource.fetchQuizes()
            .map { QuizModel(from: $0) }
    }

    func fetchQuizes(for category: CategoryModel) async throws -> [QuizModel] {
        let categoryDataModel = CategoryDataModel(from: category)

        return try await quizNetworkDataSource.fetchQuizes(for: categoryDataModel)
            .map { QuizModel(from: $0) }
    }

    func getQuestions(for quizId: Int) async throws -> QuizQuestionModel {
        let session = try await quizNetworkDataSource.getQuestions(for: quizId)
        let questions = session.questions
            .map { QuestionModel(from: $0) }
        let sessionId = session.sessionId

        return QuizQuestionModel(sessionId: sessionId, questions: questions)
    }

    func endQuizSession(for id: String, correctQuestions: Int) async throws {
        try await quizNetworkDataSource.endQuizSession(for: id, correctQuestions: correctQuestions)
    }

}
