import Foundation
import Resolver

protocol UserUseCaseProtocol {

    var userInfo: UserModel { get async throws }

    func update(name: String) async

}

final class UserUseCase: UserUseCaseProtocol {

    @Injected private var userNetworkDataSource: UserNetworkDataSourceProtocol

    var userInfo: UserModel {
        get async throws {
            let dataModel = try await userNetworkDataSource.userInfo
            return UserModel(username: dataModel.username, name: dataModel.name)
        }
    }

    func update(name: String) async {
        await userNetworkDataSource.update(name: name)
    }

}
