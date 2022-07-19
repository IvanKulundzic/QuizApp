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

    func loginUser(password: String, username: String) {
        Task(priority: .background) {
            await loginUseCase.login(username, password: password)
        }
    }

}

private extension LoginViewModel {

    func handleError(_ error: Error) {
        errorLoggingIn = error.localizedDescription
    }

}
