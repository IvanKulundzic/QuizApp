import Foundation

protocol UserUseCaseProtocol {

    func getUserInfo() async -> UserDataModel

}

final class UserUseCase: UserUseCaseProtocol {

    private let userNetworkDataSource: UserNetworkDataSourceProtocol

    init(userNetworkDataSource: UserNetworkDataSourceProtocol) {
        self.userNetworkDataSource = userNetworkDataSource
    }

    func getUserInfo() async -> UserDataModel {
        await userNetworkDataSource.getUserInfo()
    }

}
