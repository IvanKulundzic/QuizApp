import Foundation

protocol QuizNetworkDataSourceProtocol {

    func fetchQuizes() async throws -> [QuizDataModel]

}

final class QuizNetworkDataSource: QuizNetworkDataSourceProtocol {

    private let quizNetworkClient: QuizNetworkClientProtocol

    init(quizNetworkClient: QuizNetworkClientProtocol) {
        self.quizNetworkClient = quizNetworkClient
    }

    func fetchQuizes() async throws -> [QuizDataModel] {
        let networkModels = try await quizNetworkClient.fetchQuizes()
        var dataModels: [QuizDataModel] = []

        return networkModels.map { model in
            let dataModel = QuizDataModel(from: model)
            dataModels.append(dataModel)
            return dataModel
        }
    }

}
