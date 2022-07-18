import Foundation

protocol LoginServiceProtocol {

    func loginUser(_ password: String, username: String) async throws -> LoginResponseModel

}

final class LoginService: LoginServiceProtocol {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
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
            let response: LoginResponseModel = try await networkService.executeUrlRequest(request)
            value = response
        } catch {
            throw RequestError.responseError
        }

        return value
    }
}
