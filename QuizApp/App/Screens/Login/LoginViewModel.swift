import Foundation
import Combine

final class LoginViewModel {

    @Published var errorMessage = ""
    private let loginUseCase: LoginUseCaseProtocol

    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }

}

extension LoginViewModel {

    func loginUser(password: String, username: String) {
        Task(priority: .background) {
            do {
                try await loginUseCase.login(username: username, password: password)
            } catch {
                handleError(error)
            }
        }
    }

}

private extension LoginViewModel {

    func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
    }

}
