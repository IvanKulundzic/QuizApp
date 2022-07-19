import Foundation
import KeychainAccess

protocol SecureStorageProtocol {

    func save(_ token: String)

}

final class SecureStorage: SecureStorageProtocol {

    enum Key: String {

        case accessToken

    }

    static let shared = SecureStorage()
    private let keychainService = Keychain(service: "com.ivankulundzic.QuizApp")

    private init() { }

    func save(_ token: String) {
        keychainService[Key.accessToken.rawValue] = token
    }

}
