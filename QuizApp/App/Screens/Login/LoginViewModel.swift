import Foundation
import Combine
import Factory

final class LoginViewModel {

    @Injected(Container.loginUseCase) private var loginUseCase
    @Injected(Container.coordinator) private var coordinator
    @Published var errorMessage = ""
    @Published var isLoginButtonEnabled = false

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
