import UIKit

final class SearchViewController: UIViewController {

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
extension SearchViewController: ConstructViewsProtocol {

    func createViews() {

    }

    func styleViews() {
        view.backgroundColor = .red
    }

    func defineLayoutForViews() {

    }

    func setupTabBar() {
        tabBarItem.title = "Search"
        tabBarItem.image = UIImage.searchIcon?.withRenderingMode(.alwaysOriginal)
    }

}
