import Foundation

protocol QuizUseCaseProtocol {

    func fetchQuizes() async throws -> [QuizModel]

    func fetchQuizes(for category: CategoryModel) async throws -> [QuizModel]

}

final class QuizUseCase: QuizUseCaseProtocol {

    private let quizNetworkDataSource: QuizNetworkDataSourceProtocol

    init(quizNetworkDataSource: QuizNetworkDataSourceProtocol) {
        self.quizNetworkDataSource = quizNetworkDataSource
    }

    func fetchQuizes() async throws -> [QuizModel] {
        var models: [QuizModel] = []
        
        do {
            models = try await quizNetworkDataSource.fetchQuizes()
                .map { QuizModel(from: $0) }
        } catch {
            throw error.self
        }

        return models
    }

    func fetchQuizes(for category: CategoryModel) async throws -> [QuizModel] {
        let categoryDataModel = CategoryDataModel(from: category)
        var models: [QuizModel] = []

        do {
            models = try await quizNetworkDataSource.fetchQuizes(for: categoryDataModel)
                .map { QuizModel(from: $0) }
        } catch {
            throw error.self
        }

        return models
    }

}
