import Foundation
import KeychainAccess

protocol SecureStorageProtocol {

    var accessToken: String? { get }

    func save(_ token: String)

    func deleteToken() throws

}

final class SecureStorage: SecureStorageProtocol {

    enum SecureStorageError: Error {

        case deleteFailed

    }

    enum Key: String {

        case accessToken

    }

    var accessToken: String? {
        try? keychainService.get(Key.accessToken.rawValue)
    }

    private let keychainService = Keychain(service: "com.ivankulundzic.QuizApp")

    func save(_ token: String) {
        keychainService[Key.accessToken.rawValue] = token
    }

    func deleteToken() throws {
        do {
            try keychainService.remove(Key.accessToken.rawValue)
        } catch {
            throw SecureStorageError.deleteFailed
        }

    }

}
