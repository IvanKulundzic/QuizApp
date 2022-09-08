import Foundation
import Resolver

protocol LoginDataSourceProtocol {

    func login(username: String, password: String) async throws -> LoginDataModel

}

final class LoginDataSource: LoginDataSourceProtocol {

    @Injected private var loginNetworkClient: LoginNetworkClientProtocol

    func login(username: String, password: String) async throws -> LoginDataModel {
        let response = try await loginNetworkClient.login(username, password: password)
        let model = LoginDataModel(accessToken: response.accessToken)
        return model
    }

}
