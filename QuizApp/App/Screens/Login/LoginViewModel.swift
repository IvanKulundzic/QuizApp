import Foundation

final class LoginViewModel {

    var onErrorLogingIn: ((String) -> Void)?

    private let loginService: LoginServiceProtocol

    // MARK: - Init

    init(loginService: LoginServiceProtocol) {
        self.loginService = loginService
    }

}

extension LoginViewModel {

    func loginUser() async {
        let password = "navi55"
        let username = "ivan.kulundzic@endava.com"
        do {
            let token = try await loginService.loginUser(password, username: username)
            print("Token: \(token)")
        } catch {
            handleError(error)
        }
    }

}

private extension LoginViewModel {

    func handleError(_ error: Error) {
        onErrorLogingIn?(error.localizedDescription)
    }

}
