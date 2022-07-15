import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    /// It is safe to force unwrap a coordinator here, as we want the app to crash
    /// if something is not setup correctly.
    private var appCoordinator: Coordinator!

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
        appCoordinator = AppCoordinator()
        let initialViewController = appCoordinator.start()
        window.rootViewController = initialViewController
        window.makeKeyAndVisible()
    }

}
