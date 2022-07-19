import Foundation

protocol LoginUseCaseProtocol {

    func login(username: String, password: String) async throws

}

final class LoginUseCase: LoginUseCaseProtocol {

    private let loginDataSource: LoginDataSourceProtocol

    init(loginDataSource: LoginDataSourceProtocol) {
        self.loginDataSource = loginDataSource
    }

    func login(username: String, password: String) async throws {
        let token = try await loginDataSource.login(username: username, password: password).accessToken
        SecureStorage.shared.save(token)
    }
}
