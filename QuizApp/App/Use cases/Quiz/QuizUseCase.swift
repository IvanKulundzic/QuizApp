import Foundation
import Factory

protocol QuizUseCaseProtocol {

    func fetchQuizes() async throws -> [QuizModel]

    func fetchQuizes(for category: CategoryModel) async throws -> [QuizModel]

    func startQuizSession(for id: Int) async throws -> [QuestionModel]

}

final class QuizUseCase: QuizUseCaseProtocol {

    @Injected(QuizContainer.quizNetworkDataSource) private var quizNetworkDataSource

    func fetchQuizes() async throws -> [QuizModel] {
        return try await quizNetworkDataSource.fetchQuizes()
            .map { QuizModel(from: $0) }
    }

    func fetchQuizes(for category: CategoryModel) async throws -> [QuizModel] {
        let categoryDataModel = CategoryDataModel(from: category)

        return try await quizNetworkDataSource.fetchQuizes(for: categoryDataModel)
            .map { QuizModel(from: $0) }
    }

    func startQuizSession(for id: Int) async throws -> [QuestionModel] {
        return try await quizNetworkDataSource.startQuizSession(for: id)
            .map { QuestionModel(from: $0) }
    }

}
