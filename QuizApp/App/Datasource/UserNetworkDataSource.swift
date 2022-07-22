import Foundation

protocol UserNetworkDataSourceProtocol {

    func checkUserAccessToken() async throws

}

final class UserNetworkDataSource: UserNetworkDataSourceProtocol {

    private let checkNetworkClient: CheckNetworkClientProtocol

    init(checkNetworkClient: CheckNetworkClientProtocol) {
        self.checkNetworkClient = checkNetworkClient
    }

    func checkUserAccessToken() async throws {
        try await checkNetworkClient.checkAccessToken()
    }

}
