import Foundation

protocol ServiceFactoryProtocol {

    var networkClient: NetworkClientProtocol { get set }
    var loginNetworkClient: LoginNetworkClientProtocol { get set }
    var loginDataSource: LoginDataSourceProtocol { get set }
    var loginUseCase: LoginUseCaseProtocol { get set }
    var secureStorage: SecureStorageProtocol { get set }
}

final class ServiceFactory: ServiceFactoryProtocol {

    lazy var networkClient: NetworkClientProtocol = {
        NetworkClient()
    }()

    lazy var loginNetworkClient: LoginNetworkClientProtocol = {
        LoginNetworkClient(networkClient: networkClient)
    }()

    lazy var loginDataSource: LoginDataSourceProtocol = {
        LoginDataSource(loginNetworkClient: loginNetworkClient)
    }()

    lazy var loginUseCase: LoginUseCaseProtocol = {
        LoginUseCase(loginDataSource: loginDataSource, secureStorage: secureStorage)
    }()

    lazy var secureStorage: SecureStorageProtocol = {
        SecureStorage()
    }()

}
