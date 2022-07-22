import Foundation

protocol UserUseCaseProtocol {

    var userInfo: UserDataModel { get async throws }

    func update(name: String) async

}

final class UserUseCase: UserUseCaseProtocol {

    private let userNetworkDataSource: UserNetworkDataSourceProtocol

    init(userNetworkDataSource: UserNetworkDataSourceProtocol) {
        self.userNetworkDataSource = userNetworkDataSource
    }

    var userInfo: UserDataModel {
        get async throws {
            try await userNetworkDataSource.userInfo
        }
    }

    func update(name: String) async {
        await userNetworkDataSource.update(name: name)
    }

}
