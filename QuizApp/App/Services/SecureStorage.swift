import Foundation
import KeychainAccess

final class SecureStorage {

    static let shared = SecureStorage()
    private let keychainService = Keychain(service: "com.ivankulundzic.QuizApp")

    private init() { }

    func save(_ token: String) {
        keychainService["accessToken"] = token
    }

}
