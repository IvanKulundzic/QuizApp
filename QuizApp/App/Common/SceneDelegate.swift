import UIKit
import Factory

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    @Injected(Container.coordinator) private var coordinator
    @Injected(Container.secureStorage) private var secureStorage
    @Injected(Container.navigationController) private var navigationController
    @Injected(UserContainer.userNetworkDataSource) private var userNetworkDataSource

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
        coordinator = Coordinator()
        checkUserToken()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

    }

    func checkUserToken() {
        Task {
            do {
                try await userNetworkDataSource.checkUserAccessToken()
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
