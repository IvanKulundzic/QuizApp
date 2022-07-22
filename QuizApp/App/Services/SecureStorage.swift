import Foundation
import KeychainAccess

protocol SecureStorageProtocol {

    func save(_ token: String)

    func getToken() throws -> String

    func deleteToken() throws

}

final class SecureStorage: SecureStorageProtocol {

    enum SecureStorageError: Error {

        case errorGettingToken
        case errorDeletingToken

        var description: String {
            switch self {
            case .errorGettingToken:
                return "There was an error getting the user access token."
            case .errorDeletingToken:
                return "There was an error deleting the user access token."
            }
        }

    }

    enum Key: String {

        case accessToken

    }

    private let keychainService = Keychain(service: "com.ivankulundzic.QuizApp")

    func save(_ token: String) {
        keychainService[Key.accessToken.rawValue] = token
    }

    func getToken() throws -> String {
        guard let token = try keychainService.get(Key.accessToken.rawValue) else {
            throw SecureStorageError.errorGettingToken
        }
        return token
    }

    func deleteToken() throws {
        do {
            try keychainService.remove(Key.accessToken.rawValue)
        } catch {
            throw SecureStorageError.errorDeletingToken
        }

    }

}
