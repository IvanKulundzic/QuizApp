import Foundation

protocol UserUseCaseProtocol {

    func getUserInfo() async -> UserDataModel

    func update(_ name: String) async

}

final class UserUseCase: UserUseCaseProtocol {

    private let userNetworkDataSource: UserNetworkDataSourceProtocol

    init(userNetworkDataSource: UserNetworkDataSourceProtocol) {
        self.userNetworkDataSource = userNetworkDataSource
    }

    func getUserInfo() async -> UserDataModel {
        await userNetworkDataSource.getUserInfo()
    }

    func update(_ name: String) async {
        await userNetworkDataSource.update(name)
    }

}
