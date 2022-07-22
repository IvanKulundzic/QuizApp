import Foundation

protocol CheckNetworkClientProtocol {

    func checkAccessToken() async throws

}

final class CheckNetworkClient: CheckNetworkClientProtocol {

    private let networkClient: NetworkClientProtocol
    private let secureStorage: SecureStorageProtocol

    init(networkClient: NetworkClientProtocol, secureStorage: SecureStorageProtocol) {
        self.networkClient = networkClient
        self.secureStorage = secureStorage
    }

    func checkAccessToken() async throws {
        guard let url = URL(string: Endpoint(type: .check).path) else {
            throw RequestError.invalidUrl
        }
        var request = URLRequest(url: url)
        let token = try secureStorage.getToken()
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPRequestMethods.get.rawValue

        do {
            try await networkClient.executeUrlRequest(request)
        } catch {
            throw RequestError.responseError
        }
    }

}
