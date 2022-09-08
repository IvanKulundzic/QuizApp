import UIKit
import Resolver

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    @Injected private var navigationController: UINavigationController
    @Injected private var coordinator: CoordinatorProtocol
    @Injected private var secureStorage: SecureStorageProtocol
    @Injected private var datasource: UserNetworkDataSourceProtocol

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        setupInitialScene(with: scene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}

// MARK: - Private methods
private extension SceneDelegate {

    func setupInitialScene(with scene: UIWindowScene) {
        let window = UIWindow(windowScene: scene)
        self.window = window
        checkUserToken()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func checkUserToken() {
        Task {
            do {
                try await datasource.checkUserAccessToken()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.coordinator.showHome()
                }
            } catch {
                try? secureStorage.deleteToken()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.coordinator.showLogin()
                }
            }
        }
    }

}
