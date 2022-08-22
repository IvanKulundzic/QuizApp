import Foundation

protocol QuizUseCaseProtocol {

    func fetchQuizes() async throws -> [QuizModel]

    func fetchQuizes(for category: String) async throws -> [QuizModel]

}

final class QuizUseCase: QuizUseCaseProtocol {

    private let quizNetworkDataSource: QuizNetworkDataSourceProtocol

    init(quizNetworkDataSource: QuizNetworkDataSourceProtocol) {
        self.quizNetworkDataSource = quizNetworkDataSource
    }

    func fetchQuizes() async throws -> [QuizModel] {
        try await quizNetworkDataSource.fetchQuizes()
            .map { QuizModel(from: $0) }
    }

    func fetchQuizes(for category: String) async throws -> [QuizModel] {
        try await quizNetworkDataSource.fetchQuizes(for: category)
            .map { QuizModel(from: $0) }
    }

}
