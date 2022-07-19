import Foundation
import Combine

final class LoginViewModel {

    @Published var errorLoggingIn = ""
    private let loginUseCase: LoginUseCaseProtocol

    // MARK: - Init

    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }

}

extension LoginViewModel {

    func loginUser(password: String, username: String) async {
        do {
            let token = try await loginUseCase.loginUser(password, username: username).accessToken
            /// Save the token to Keychain
            let keychainService = SecureStorage()
            keychainService.save(token)
        } catch {
            handleError(error)
        }
    }

}

private extension LoginViewModel {

    func handleError(_ error: Error) {
        errorLoggingIn = error.localizedDescription
    }

}
