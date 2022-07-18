import Foundation
import Combine

final class LoginViewModel {

    @Published var errorLoggingIn: String = ""
    private let loginService: LoginServiceProtocol

    // MARK: - Init

    init(loginService: LoginServiceProtocol) {
        self.loginService = loginService
    }

}

extension LoginViewModel {

    func loginUser(password: String, username: String) async {
        do {
            let token = try await loginService.loginUser(password, username: username)
            /// Save the token to Keychain
            let keychainService = KeychainService()
            keychainService.save(token.accessToken)
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
