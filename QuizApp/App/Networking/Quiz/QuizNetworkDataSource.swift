import Foundation

protocol QuizNetworkDataSourceProtocol {

    func fetchQuizes() async throws -> [QuizDataModel]

    func fetchQuizes(for category: String) async throws -> [QuizDataModel]

}

final class QuizNetworkDataSource: QuizNetworkDataSourceProtocol {

    private let quizNetworkClient: QuizNetworkClientProtocol

    init(quizNetworkClient: QuizNetworkClientProtocol) {
        self.quizNetworkClient = quizNetworkClient
    }

    func fetchQuizes() async throws -> [QuizDataModel] {
        try await quizNetworkClient.fetchQuizes()
            .map { QuizDataModel(from: $0) }
    }

    func fetchQuizes(for category: String) async throws -> [QuizDataModel] {
        try await quizNetworkClient.fetchQuizes(for: category)
            .map { QuizDataModel(from: $0) }
    }

}
