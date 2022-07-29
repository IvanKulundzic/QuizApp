import Foundation

protocol QuizUseCaseProtocol {

    func fetchQuizes(for category: CategoryNetworkModel) async throws -> [QuizModel]

}

final class QuizUseCase: QuizUseCaseProtocol {

    private let quizNetworkDataSource: QuizNetworkDataSourceProtocol

    init(quizNetworkDataSource: QuizNetworkDataSourceProtocol) {
        self.quizNetworkDataSource = quizNetworkDataSource
    }

    func fetchQuizes(for category: CategoryNetworkModel) async throws -> [QuizModel] {
        var quizes: [QuizModel] = []
        let dataModels = try await quizNetworkDataSource.fetchQuizes(for: category)

        dataModels
            .forEach { model in
                let quiz = QuizModel(from: model)
                if quiz.category == category {
                    quizes.append(quiz)
                }
            }

        return quizes
    }

}
