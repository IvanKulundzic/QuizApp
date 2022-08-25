import Foundation
import Combine

final class LoginViewModel {

    @Published var errorMessage = ""
    @Published var isLoginButtonEnabled = false
    private let coordinator: CoordinatorProtocol
    private let loginUseCase: LoginUseCaseProtocol

    init(loginUseCase: LoginUseCaseProtocol, coordinator: CoordinatorProtocol) {
        self.loginUseCase = loginUseCase
        self.coordinator = coordinator
    }

}

extension LoginViewModel {

    func loginUser(password: String, username: String) {
        Task {
            do {
                try await loginUseCase.login(username: username, password: password)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.coordinator.showHome()
                }
            } catch {
                handleError(error)
            }
        }
    }

    func validate(username: String, password: String) {
        let validator = LoginValidator(username: username, password: password)
        isLoginButtonEnabled = validator.isValid
    }

}

private extension LoginViewModel {

    func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
    }

}
