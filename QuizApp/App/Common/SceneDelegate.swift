import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    /// It is safe to force unwrap a coordinator here, as we want the app to crash
    /// if something is not setup correctly.
    private var coordinator: CoordinatorProtocol!
    private var serviceFactory: ServiceFactory!

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
        let navigationController = UINavigationController()
        coordinator = Coordinator(navigationController: navigationController)
        serviceFactory = ServiceFactory()
        checkUserToken()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

    }

    func checkUserToken() {
        let datasource = serviceFactory.userNetworkDataSource
        let secureStorage = serviceFactory.secureStorage
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
