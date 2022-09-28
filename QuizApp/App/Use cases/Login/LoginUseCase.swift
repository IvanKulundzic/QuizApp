import Foundation
import Factory

protocol LoginUseCaseProtocol {

    func login(username: String, password: String) async throws

}

final class LoginUseCase: LoginUseCaseProtocol {

    @Injected(LoginContainer.loginDataSource) private var loginDataSource
    @Injected(Container.secureStorage) private var secureStorage

    func login(username: String, password: String) async throws {
        let token = try await loginDataSource.login(username: username, password: password).accessToken
        secureStorage.save(token)
    }
}
