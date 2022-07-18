import Foundation
import KeychainAccess

protocol KeychainServiceProtocol {
    func save(_ token: String)
}

final class KeychainService: KeychainServiceProtocol {

    private let service = Keychain(service: "com.ivankulundzic.QuizApp")

    func save(_ token: String) {
        service["ivan"] = token
    }

}
