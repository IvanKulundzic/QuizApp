import Foundation
import Factory

protocol QuizNetworkDataSourceProtocol {

    func fetchQuizes() async throws -> [QuizDataModel]

    func fetchQuizes(for category: CategoryDataModel) async throws -> [QuizDataModel]

    func getQuestions(for quizId: Int) async throws -> [QuestionDataModel]

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

    func getQuestions(for quizId: Int) async throws -> [QuestionDataModel] {
        return try await quizNetworkClient.startQuizSession(for: quizId)
            .map { QuestionDataModel(from: $0) }
    }

}
