import Foundation
import Factory

protocol UserUseCaseProtocol {

    var userInfo: UserModel { get async throws }

    func update(name: String) async

}

final class UserUseCase: UserUseCaseProtocol {

    @Injected(Container.userNetworkDataSource) private var userNetworkDataSource

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
