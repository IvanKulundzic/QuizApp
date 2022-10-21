import Foundation
import Factory

protocol QuizUseCaseProtocol {

    func fetchQuizes() async throws -> [QuizModel]

    func fetchQuizes(for category: CategoryModel) async throws -> [QuizModel]

    func getQuestions(for quizId: Int) async throws -> ([QuestionModel], String)

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

    func getQuestions(for quizId: Int) async throws -> ([QuestionModel], String) {
        let session = try await quizNetworkDataSource.getQuestions(for: quizId)
        let questions = session.0
            .map { QuestionModel(from: $0) }
        let sessionId = session.1

        return (questions, sessionId)
    }

    func endQuizSession(for id: String, correctQuestions: Int) async throws {
        try await quizNetworkDataSource.endQuizSession(for: id, correctQuestions: correctQuestions)
    }

}
