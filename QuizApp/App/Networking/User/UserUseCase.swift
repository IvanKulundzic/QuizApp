import Foundation

protocol UserUseCaseProtocol {

    var userInfo: UserModel { get async throws }

    func update(name: String) async

}

final class UserUseCase: UserUseCaseProtocol {

    private let userNetworkDataSource: UserNetworkDataSourceProtocol

    init(userNetworkDataSource: UserNetworkDataSourceProtocol) {
        self.userNetworkDataSource = userNetworkDataSource
    }

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
