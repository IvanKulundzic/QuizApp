import Foundation

protocol LoginUseCaseProtocol {

    func login(username: String, password: String) async throws

}

final class LoginUseCase: LoginUseCaseProtocol {

    private let loginDataSource: LoginDataSourceProtocol
    private let secureStorage: SecureStorageProtocol

    init(loginDataSource: LoginDataSourceProtocol, secureStorage: SecureStorageProtocol) {
        self.loginDataSource = loginDataSource
        self.secureStorage = secureStorage
    }

    func login(username: String, password: String) async throws {
        let token = try await loginDataSource.login(username: username, password: password).accessToken
        secureStorage.save(token)
    }
}
