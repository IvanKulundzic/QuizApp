import UIKit

/// Top level coordinator implementation, responsible for firing off main app flows,
/// i.e. login flow, maybe unauthenticated user flow, or even offline mode flow, to
/// name a few.
final class AppCoordinator: Coordinator {

    func start() -> UIViewController {
        startLoginFlow()
    }

}

// MARK: - Private methods
private extension AppCoordinator {

    func startLoginFlow() -> UIViewController {
        let loginCoordinator = LoginCoordinator()
        return loginCoordinator.start()
    }

}
