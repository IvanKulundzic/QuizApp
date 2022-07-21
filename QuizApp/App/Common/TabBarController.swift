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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

}

// MARK: - Private methods
private extension TabBarController {

    func setupNavigationBar() {
        guard let viewControllers = viewControllers else { return }

        for viewController in viewControllers {
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: Fonts.sourceSansProBold24.font
            ]

            switch viewController {
            case is QuizViewController:
                title = "PopQuiz"
            default:
                title = ""
            }
        }
    }

    func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }

}
