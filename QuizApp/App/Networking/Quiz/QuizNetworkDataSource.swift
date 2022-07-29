import Foundation

protocol QuizNetworkDataSourceProtocol {

    func fetchQuizes(for category: CategoryNetworkModel) async throws -> [QuizDataModel]

}

final class QuizNetworkDataSource: QuizNetworkDataSourceProtocol {

    private let quizNetworkClient: QuizNetworkClientProtocol

    init(quizNetworkClient: QuizNetworkClientProtocol) {
        self.quizNetworkClient = quizNetworkClient
    }

    func fetchQuizes(for category: CategoryNetworkModel) async throws -> [QuizDataModel] {
        let networkModels = try await quizNetworkClient.fetchQuizes(for: category)
        var dataModels: [QuizDataModel] = []

        for model in networkModels {
            let dataModel = QuizDataModel(from: model)
            dataModels.append(dataModel)
        }

        return dataModels
    }

}
