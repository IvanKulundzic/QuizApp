import Foundation

protocol QuizNetworkDataSourceProtocol {

    func fetchQuizes() async throws -> [QuizDataModel]

    func fetchQuizes(for category: CategoryDataModel) async throws -> [QuizDataModel]

}

final class QuizNetworkDataSource: QuizNetworkDataSourceProtocol {

    private let quizNetworkClient: QuizNetworkClientProtocol

    init(quizNetworkClient: QuizNetworkClientProtocol) {
        self.quizNetworkClient = quizNetworkClient
    }

    func fetchQuizes() async throws -> [QuizDataModel] {
        var models: [QuizDataModel] = []
        do {
            models = try await quizNetworkClient.fetchQuizes()
                .map { QuizDataModel(from: $0) }
        } catch {
            throw RequestError.serverError
        }
        return models
    }

    func fetchQuizes(for category: CategoryDataModel) async throws -> [QuizDataModel] {
        var models: [QuizDataModel] = []
        let categoryNetworkModel = CategoryNetworkModel(from: category)

        do {
            models = try await quizNetworkClient.fetchQuizes(for: categoryNetworkModel)
                .map { QuizDataModel(from: $0) }
        } catch {
            throw error.self
        }
        
        return models
    }

}
