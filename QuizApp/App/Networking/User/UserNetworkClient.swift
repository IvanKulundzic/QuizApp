import Foundation
import Resolver

protocol UserNetworkClientProtocol {

    var userInfo: UserResponseModel? { get async throws }

    func update(name: String) async throws
}

final class UserNetworkClient: UserNetworkClientProtocol {

    @Injected private var networkClient: NetworkClientProtocol
    @Injected private var secureStorage: SecureStorageProtocol

    var userInfo: UserResponseModel? {
        get async throws {
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

    func update(name: String) async throws {
        guard let url = URL(string: Endpoint(type: .account).path) else {
            throw RequestError.invalidUrl
        }

        var request = URLRequest(url: url)
        let token = secureStorage.accessToken ?? ""
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(UserRequestBody(name: name))
        request.httpMethod = HTTPRequestMethods.patch.rawValue

        return try await networkClient.executeUrlRequest(request)
    }

}
