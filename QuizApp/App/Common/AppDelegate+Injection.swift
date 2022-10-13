import UIKit
import Factory

extension Container {

    // MARK: - Common

    static let coordinator = Factory(scope: .shared) { Coordinator() as CoordinatorProtocol }
    static let navigationController = Factory(scope: .shared) { UINavigationController() }

    // MARK: - Services
    static let networkClient = Factory(scope: .singleton) { NetworkClient() as NetworkClientProtocol }
    static let secureStorage = Factory(scope: .singleton) { SecureStorage() as SecureStorageProtocol }
    static let checkNetworkClient = Factory(scope: .singleton) { CheckNetworkClient() as CheckNetworkClientProtocol }

}

final class LoginContainer: SharedContainer {

    static let loginNetworkClient = Factory(scope: .singleton) { LoginNetworkClient() as LoginNetworkClientProtocol }
    static let loginDataSource = Factory(scope: .singleton) { LoginDataSource() as LoginDataSourceProtocol }
    static let loginUseCase = Factory(scope: .singleton) { LoginUseCase() as LoginUseCaseProtocol }
    static let loginViewModel = Factory { LoginViewModel() }
    static let loginViewController = Factory { LoginViewController() }

}

final class UserContainer: SharedContainer {

    static let userNetworkClient = Factory(scope: .singleton) { UserNetworkClient() as UserNetworkClientProtocol }
    static let userNetworkDataSource = Factory(scope: .singleton) {
        UserNetworkDataSource() as UserNetworkDataSourceProtocol
    }
    static let userUseCase = Factory(scope: .singleton) { UserUseCase() as UserUseCaseProtocol }
    static let userViewModel = Factory { UserViewModel() }
    static let userViewController = Factory { UserViewController() }

}

final class QuizContainer: SharedContainer {

    static let quizNetworkClient = Factory(scope: .singleton) { QuizNetworkClient() as QuizNetworkClientProtocol }
    static let quizNetworkDataSource = Factory(scope: .singleton) {
        QuizNetworkDataSource() as QuizNetworkDataSourceProtocol
    }
    static let quizUseCase = Factory(scope: .singleton) { QuizUseCase() as QuizUseCaseProtocol }
    static let quizListViewModel = Factory { QuizListViewModel() }
    static let quizListViewController = Factory { QuizListViewController() }

}

final class QuizDetailsContainer: SharedContainer {

    static let quizDetailsViewModel = ParameterFactory<QuizViewModel, QuizDetailsViewModel> { quiz in
        QuizDetailsViewModel(quiz: quiz, coordinator: Container.coordinator())
    }
    static let quizDetailsViewController = ParameterFactory<QuizDetailsViewModel, QuizDetailsViewController> { model in
        QuizDetailsViewController(viewModel: model)
    }

}

final class LeaderboardContainer: SharedContainer {

    static let leaderboardViewModel = Factory { LeaderboardViewModel(coordinator: Container.coordinator()) }
    static let leaderboardViewController = Factory { LeaderboardViewController(viewModel: leaderboardViewModel()) }

}

final class QuizResultContainer: SharedContainer {

    static let quizResultViewController = Factory { QuizResultViewController() }

}
