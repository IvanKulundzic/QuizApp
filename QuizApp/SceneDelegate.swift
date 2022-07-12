//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Ivan Kulundžić on 12.07.2022..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
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
        let initialViewController = ViewController()
        window.rootViewController = initialViewController
        window.makeKeyAndVisible()
    }

}
