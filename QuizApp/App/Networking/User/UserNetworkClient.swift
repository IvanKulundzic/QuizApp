import Foundation

protocol UserNetworkClientProtocol {
    func getUserInfo() async throws -> UserResponseModel
}

final class UserNetworkClient: UserNetworkClientProtocol {

    private let networkClient: NetworkClientProtocol
    private let secureStorage: SecureStorageProtocol

    init(networkClient: NetworkClientProtocol, secureStorage: SecureStorageProtocol) {
        self.networkClient = networkClient
        self.secureStorage = secureStorage
    }

    func getUserInfo() async throws -> UserResponseModel {
        guard let url = URL(string: Endpoint(type: .account).path) else {
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
