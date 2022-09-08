import Resolver
import UIKit

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {
        register { NetworkClient() }
            .implements(NetworkClientProtocol.self)
            .scope(.application)

        register { SecureStorage() }
            .implements(SecureStorageProtocol.self)
            .scope(.application)

        register { CheckNetworkClient() }
            .implements(CheckNetworkClientProtocol.self)
            .scope(.application)

        register { Coordinator() }
            .implements(CoordinatorProtocol.self)
            .scope(.application)

        register { UINavigationController() }
            .scope(.application)

        registerLoginDependencies()
        registerUserDependencies()
        registerQuizDependencies()
    }

    public static func registerLoginDependencies() {
        register { LoginNetworkClient() }
            .implements(LoginNetworkClientProtocol.self)
            .scope(.application)

        register { LoginDataSource() }
            .implements(LoginDataSourceProtocol.self)
            .scope(.application)

        register { LoginUseCase() }
            .implements(LoginUseCaseProtocol.self)
            .scope(.application)
    }

    public static func registerUserDependencies() {
        register { UserNetworkClient() }
            .implements(UserNetworkClientProtocol.self)
            .scope(.application)

        register { UserNetworkDataSource() }
            .implements(UserNetworkDataSourceProtocol.self)
            .scope(.application)

        register { UserUseCase() }
            .implements(UserUseCaseProtocol.self)
            .scope(.application)
    }

    public static func registerQuizDependencies() {
        register { QuizNetworkClient() }
            .implements(QuizNetworkClientProtocol.self)
            .scope(.application)

        register { QuizNetworkDataSource() }
            .implements(QuizNetworkDataSourceProtocol.self)
            .scope(.application)

        register { QuizUseCase() }
            .implements(QuizUseCaseProtocol.self)
            .scope(.application)
    }

}
