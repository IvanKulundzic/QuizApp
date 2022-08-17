import Foundation

protocol QuizUseCaseProtocol {

    func fetchQuizes() async throws -> [QuizModel]

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

}
