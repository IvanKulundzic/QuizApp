import Foundation
import Factory

protocol UserNetworkDataSourceProtocol {

    var userInfo: UserDataModel { get async throws }

    func checkUserAccessToken() async throws

    func update(name: String) async

}

final class UserNetworkDataSource: UserNetworkDataSourceProtocol {

    @Injected(Container.checkNetworkClient) private var checkNetworkClient
    @Injected(Container.userNetworkClient) private var userNetworkClient

    var userInfo: UserDataModel {
        get async throws {
            let responseModel = try await userNetworkClient.userInfo
            let username = responseModel?.email ?? ""
            let name = responseModel?.name ?? ""
            return UserDataModel(username: username, name: name)
        }
    }

    func checkUserAccessToken() async throws {
        try await checkNetworkClient.checkAccessToken()
    }

    func update(name: String) async {
        try? await userNetworkClient.update(name: name)
    }

}
