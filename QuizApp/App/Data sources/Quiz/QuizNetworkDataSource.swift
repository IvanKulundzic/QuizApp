import Foundation
import Factory

protocol QuizNetworkDataSourceProtocol {

    func fetchQuizes() async throws -> [QuizDataModel]

    func fetchQuizes(for category: CategoryDataModel) async throws -> [QuizDataModel]

    func getQuestions(for quizId: Int) async throws -> ([QuestionDataModel], String)

    func endQuizSession(for id: String, correctQuestions: Int) async throws

}

final class QuizNetworkDataSource: QuizNetworkDataSourceProtocol {

    @Injected(QuizContainer.quizNetworkClient) private var quizNetworkClient

    func fetchQuizes() async throws -> [QuizDataModel] {
        return try await quizNetworkClient.fetchQuizes()
            .map { QuizDataModel(from: $0) }
    }

    func fetchQuizes(for category: CategoryDataModel) async throws -> [QuizDataModel] {
        let categoryNetworkModel = CategoryNetworkModel(from: category)

        return try await quizNetworkClient.fetchQuizes(for: categoryNetworkModel)
            .map { QuizDataModel(from: $0) }
    }

    func getQuestions(for quizId: Int) async throws -> ([QuestionDataModel], String) {
        let session = try await quizNetworkClient.startQuizSession(for: quizId)
        let questions = session.questions
            .map { QuestionDataModel(from: $0) }
        let sessionId = session.sessionId

        return (questions, sessionId)
    }

    func endQuizSession(for id: String, correctQuestions: Int) async throws {
        try await quizNetworkClient.endQuizSession(for: id, correctQuestions: correctQuestions)
    }

}
