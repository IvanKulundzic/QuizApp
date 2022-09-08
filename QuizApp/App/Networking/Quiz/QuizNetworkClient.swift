import Foundation
import Resolver

protocol QuizNetworkClientProtocol {

    func fetchQuizes() async throws -> [QuizNetworkModel]

    func fetchQuizes(for category: CategoryNetworkModel) async throws -> [QuizNetworkModel]

}

final class QuizNetworkClient: QuizNetworkClientProtocol {

    @Injected private var networkClient: NetworkClientProtocol
    @Injected private var secureStorage: SecureStorageProtocol

    func fetchQuizes() async throws -> [QuizNetworkModel] {
        guard let url = URL(string: "\(Endpoint(type: .quizList).path)") else {
            throw RequestError.invalidUrl
        }

        var request = URLRequest(url: url)
        let token = secureStorage.accessToken ?? ""
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPRequestMethods.get.rawValue

        return try await networkClient.executeUrlRequest(request)
    }

    func fetchQuizes(for category: CategoryNetworkModel) async throws -> [QuizNetworkModel] {
        guard let url = URL(string: "\(Endpoint(type: .quizList).path)?category=\(category)") else {
            throw RequestError.invalidUrl
        }

        var request = URLRequest(url: url)
        let token = secureStorage.accessToken ?? ""
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPRequestMethods.get.rawValue

        return try await networkClient.executeUrlRequest(request)
    }

}
