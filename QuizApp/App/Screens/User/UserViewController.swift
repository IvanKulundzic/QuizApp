import UIKit

final class UserViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        setupTabBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleViews()
        defineLayoutForViews()
    }

}

// MARK: - ConstructViewsProtocol methods
extension UserViewController: ConstructViewsProtocol {

    func createViews() {

    }

    func styleViews() {
        view.backgroundColor = .red
    }

    func defineLayoutForViews() {

    }

    func setupTabBar() {
        tabBarItem.title = "User"
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        tabBarItem.image = UIImage(systemName: "person")
    }

}
