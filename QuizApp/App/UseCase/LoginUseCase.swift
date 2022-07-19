import Foundation

protocol LoginUseCaseProtocol {

    func loginUser(_ password: String, username: String) async throws -> LoginResponseModel

}

final class LoginUseCase: LoginUseCaseProtocol {

    private let networkClient: NetworkClienProtocol

    init(networkClient: NetworkClienProtocol) {
        self.networkClient = networkClient
    }

    func loginUser(_ password: String, username: String) async throws -> LoginResponseModel {
        guard let url = URL(string: Endpoint(type: .login).path) else {
            throw RequestError.invalidUrl
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPRequestMethods.post.rawValue
        request.httpBody = try? JSONEncoder().encode(LoginRequestBody(password: password, username: username))

        var value = LoginResponseModel(accessToken: "")

        do {
            let response: LoginResponseModel = try await networkClient.executeUrlRequest(request)
            value = response
        } catch {
            throw RequestError.responseError
        }

        return value
    }
}
