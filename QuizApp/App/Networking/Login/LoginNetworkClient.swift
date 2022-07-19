import Foundation

protocol LoginNetworkClientProtocol {

    func login(_ username: String, password: String) async throws -> LoginResponseModel

}

final class LoginNetworkClient: LoginNetworkClientProtocol {

    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func login(_ username: String, password: String) async throws -> LoginResponseModel {
        guard let url = URL(string: Endpoint(type: .login).path) else {
            throw RequestError.invalidUrl
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPRequestMethods.post.rawValue
        request.httpBody = try? JSONEncoder().encode(LoginRequestBody(password: password, username: username))

        let response: LoginResponseModel = try await networkClient.executeUrlRequest(request)
        return response
    }

}
