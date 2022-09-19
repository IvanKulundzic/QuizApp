import Foundation
import Factory

protocol QuizUseCaseProtocol {

    func fetchQuizes() async throws -> [QuizModel]

    func fetchQuizes(for category: CategoryModel) async throws -> [QuizModel]

}

final class QuizUseCase: QuizUseCaseProtocol {

    @Injected(Container.quizNetworkDataSource) private var quizNetworkDataSource

    func fetchQuizes() async throws -> [QuizModel] {
        try await quizNetworkDataSource.fetchQuizes()
            .map { QuizModel(from: $0) }
    }

    func fetchQuizes(for category: CategoryModel) async throws -> [QuizModel] {
        let categoryDataModel = CategoryDataModel(from: category)
        return try await quizNetworkDataSource.fetchQuizes(for: categoryDataModel)
            .map { QuizModel(from: $0) }
    }

}
