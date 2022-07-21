import UIKit

final class TabBarController: UITabBarController {

    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

}

// MARK: - Private methods
private extension TabBarController {

    func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .loginPurple
        selectedIndex = 0
    }

}
