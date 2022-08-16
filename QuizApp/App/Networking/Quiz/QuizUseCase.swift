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
        let dataModels = try await quizNetworkDataSource.fetchQuizes()

        return dataModels
            .map {
                let quiz = QuizModel(from: $0)
                return quiz
            }
    }

}
