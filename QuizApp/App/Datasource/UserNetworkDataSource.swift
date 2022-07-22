import Foundation

protocol UserNetworkDataSourceProtocol {

    func checkUserAccessToken() async throws

    func getUserInfo() async -> UserDataModel

}

final class UserNetworkDataSource: UserNetworkDataSourceProtocol {

    private let checkNetworkClient: CheckNetworkClientProtocol
    private let userNetworkClient: UserNetworkClientProtocol

    init(checkNetworkClient: CheckNetworkClientProtocol, userNetworkClient: UserNetworkClientProtocol) {
        self.checkNetworkClient = checkNetworkClient
        self.userNetworkClient = userNetworkClient
    }

    func checkUserAccessToken() async throws {
        try await checkNetworkClient.checkAccessToken()
    }

    func getUserInfo() async -> UserDataModel {
        let responseModel = try? await userNetworkClient.getUserInfo()
        let username = responseModel?.email ?? ""
        let name = responseModel?.name ?? ""
        return UserDataModel(username: username, name: name)
    }

}
