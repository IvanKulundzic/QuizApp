import Foundation


final class LoginValidator {

    var isValid: Bool = false
    private let username: String
    private let password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password

        validate(username: username, password: password)
    }

}

// MARK: - Private methods
private extension LoginValidator {

    func validate(username: String, password: String) {
        let isUsernameValid = validateUsername(username)
        let isPasswordValid = validatePassword(password)

        if isUsernameValid && isPasswordValid {
            isValid = true
        } else {
            isValid = false
        }
    }

    func validateUsername(_ username: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: username)
    }

    func validatePassword(_ password: String) -> Bool {
        password.count >= 6
    }

}
