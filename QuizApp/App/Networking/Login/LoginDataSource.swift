import Foundation

protocol LoginDataSourceProtocol {

    func login(_ username: String, password: String) async throws -> LoginDataModel

}

final class LoginDataSource: LoginDataSourceProtocol {

    private let loginNetworkClient: LoginNetworkClientProtocol

    init(loginNetworkClient: LoginNetworkClientProtocol) {
        self.loginNetworkClient = loginNetworkClient
    }

    func login(_ username: String, password: String) async throws -> LoginDataModel {
        guard let response = try? await loginNetworkClient.login(username, password: password) else {
            throw RequestError.responseError
        }
        let model = LoginDataModel(accessToken: response.accessToken)
        return model
    }

}
