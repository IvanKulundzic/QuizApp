import Foundation
import KeychainAccess

protocol SecureStorageProtocol {

    func save(_ token: String)

}

final class SecureStorage: SecureStorageProtocol {

    enum Key: String {

        case accessToken

    }

    private let keychainService = Keychain(service: "com.ivankulundzic.QuizApp")

    func save(_ token: String) {
        keychainService[Key.accessToken.rawValue] = token
    }

}
