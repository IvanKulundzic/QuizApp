import Foundation

protocol QuizNetworkDataSourceProtocol {

    func fetchQuizes() async throws -> [QuizDataModel]

    func fetchQuizes(for category: CategoryDataModel) async throws -> [QuizDataModel]

}

final class QuizNetworkDataSource: QuizNetworkDataSourceProtocol {

    private let quizNetworkClient: QuizNetworkClientProtocol

    init(quizNetworkClient: QuizNetworkClientProtocol) {
        self.quizNetworkClient = quizNetworkClient
    }

    func fetchQuizes() async throws -> [QuizDataModel] {
        var models: [QuizDataModel] = []

        models = try await quizNetworkClient.fetchQuizes()
            .map { QuizDataModel(from: $0) }

        return models
    }

    func fetchQuizes(for category: CategoryDataModel) async throws -> [QuizDataModel] {
        var models: [QuizDataModel] = []
        let categoryNetworkModel = CategoryNetworkModel(from: category)

        models = try await quizNetworkClient.fetchQuizes(for: categoryNetworkModel)
            .map { QuizDataModel(from: $0) }

        return models
    }

}
