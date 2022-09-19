import UIKit
import Factory

extension Container {

    // MARK: - Common

    static let coordinator = Factory(scope: .shared) { Coordinator() as CoordinatorProtocol }
    static let navigationController = Factory(scope: .shared) { UINavigationController() }

    // MARK: - Services
    static let networkClient = Factory { NetworkClient() as NetworkClientProtocol }
    static let secureStorage = Factory { SecureStorage() as SecureStorageProtocol }
    static let checkNetworkClient = Factory { CheckNetworkClient() as CheckNetworkClientProtocol }

    // MARK: - Login

    static let loginNetworkClient = Factory { LoginNetworkClient() as LoginNetworkClientProtocol }
    static let loginDataSource = Factory { LoginDataSource() as LoginDataSourceProtocol }
    static let loginUseCase = Factory { LoginUseCase() as LoginUseCaseProtocol }

    // MARK: - User

    static let userNetworkClient = Factory { UserNetworkClient() as UserNetworkClientProtocol }
    static let userNetworkDataSource = Factory { UserNetworkDataSource() as UserNetworkDataSourceProtocol }
    static let userUseCase = Factory { UserUseCase() as UserUseCaseProtocol }

    // MARK: - Quiz

    static let quizNetworkClient = Factory { QuizNetworkClient() as QuizNetworkClientProtocol }
    static let quizNetworkDataSource = Factory { QuizNetworkDataSource() as QuizNetworkDataSourceProtocol }
    static let quizUseCase = Factory { QuizUseCase() as QuizUseCaseProtocol }

    // MARK: - ViewModels

    static let loginViewModel = Factory { LoginViewModel() }
    static let userViewModel = Factory { UserViewModel() }
    static let quizListViewModel = Factory { QuizListViewModel() }

}
