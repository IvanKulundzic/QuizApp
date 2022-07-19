import Foundation

protocol LoginUseCaseProtocol {

    func login(_ username: String, password: String) async

}

final class LoginUseCase: LoginUseCaseProtocol {

    private let loginDataSource: LoginDataSourceProtocol

    init(loginDataSource: LoginDataSourceProtocol) {
        self.loginDataSource = loginDataSource
    }

    func login(_ username: String, password: String) async {
        guard let token = try? await loginDataSource.login(username, password: password).accessToken else {
            return
        }
        SecureStorage.shared.save(token)
    }
}
