import Foundation
import Factory

protocol CheckNetworkClientProtocol {

    func checkAccessToken() async throws

}

final class CheckNetworkClient: CheckNetworkClientProtocol {

    @Injected(Container.networkClient) private var networkClient
    @Injected(Container.secureStorage) private var secureStorage

    func checkAccessToken() async throws {
        guard let url = URL(string: Endpoint(type: .check).path) else {
            throw RequestError.invalidUrl
        }
        var request = URLRequest(url: url)
        let token = secureStorage.accessToken ?? ""
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPRequestMethods.get.rawValue

        do {
            try await networkClient.executeUrlRequest(request)
        } catch {
            throw RequestError.responseError
        }
    }

}
