import Foundation
import Factory

protocol QuizNetworkDataSourceProtocol {

    func fetchQuizes() async throws -> [QuizDataModel]

    func fetchQuizes(for category: CategoryDataModel) async throws -> [QuizDataModel]

}

final class QuizNetworkDataSource: QuizNetworkDataSourceProtocol {

    @Injected(Container.quizNetworkClient) private var quizNetworkClient

    func fetchQuizes() async throws -> [QuizDataModel] {
        try await quizNetworkClient.fetchQuizes()
            .map { QuizDataModel(from: $0) }
    }

    func fetchQuizes(for category: CategoryDataModel) async throws -> [QuizDataModel] {
        let categoryNetworkModel = CategoryNetworkModel(from: category)
        return try await quizNetworkClient.fetchQuizes(for: categoryNetworkModel)
            .map { QuizDataModel(from: $0) }
    }

}
