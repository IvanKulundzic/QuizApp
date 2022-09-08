import Foundation
import Resolver

protocol LoginUseCaseProtocol {

    func login(username: String, password: String) async throws

}

final class LoginUseCase: LoginUseCaseProtocol {

    @Injected private var loginDataSource: LoginDataSourceProtocol
    @Injected private var secureStorage: SecureStorageProtocol

    func login(username: String, password: String) async throws {
        let token = try await loginDataSource.login(username: username, password: password).accessToken
        secureStorage.save(token)
    }
}
