import UIKit
import Combine

final class UserViewController: UIViewController {

    private var usernameLabel: UILabel!
    private var usernameTextLabel: UILabel!
    private var logoutButton: UIButton!
    private var cancellables = Set<AnyCancellable>()
    private let userViewModel: UserViewModel

    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        super.init(nibName: nil, bundle: nil)
        setupTabBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTabBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleViews()
        defineLayoutForViews()
        bindViewModel()
        userViewModel.getUserInfo()
    }

}

// MARK: - ConstructViewsProtocol methods
extension UserViewController: ConstructViewsProtocol {

    func createViews() {
        usernameLabel = UILabel()
        view.addSubview(usernameLabel)

        usernameTextLabel = UILabel()
        view.addSubview(usernameTextLabel)

        logoutButton = UIButton()
        view.addSubview(logoutButton)
    }

    func styleViews() {
        view.applyGradientWith([UIColor.loginBackgroundTop.cgColor, UIColor.loginBackgroundBottom.cgColor])

        usernameLabel.text = "USERNAME"
        usernameLabel.textColor = .white
        usernameLabel.textAlignment = .left
        usernameLabel.font = Fonts.sourceSansProSemiBold12.font

        usernameTextLabel.text = "SportJunkie1234"
        usernameTextLabel.textColor = .white
        usernameTextLabel.textAlignment = .left
        usernameTextLabel.font = Fonts.sourceSansProBold20.font

        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.setTitleColor(.logoutOrange, for: .normal)
        logoutButton.titleLabel?.font = Fonts.sourceSansProBold16.font
        logoutButton.layer.cornerRadius = 20
        logoutButton.backgroundColor = .white
    }

    func defineLayoutForViews() {
        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        usernameTextLabel.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        logoutButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(311)
            $0.height.equalTo(44)
        }
    }

}

// MARK: - Private methods
private extension UserViewController {

    func setupTabBar() {
        tabBarItem.title = "User"
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        tabBarItem.image = UIImage(systemName: "person")
        tabBarController?.navigationItem.titleView?.isHidden = true
    }

    func bindViewModel() {

        userViewModel
            .$username
            .sink { username in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.usernameTextLabel.text = username
                }
            }
            .store(in: &cancellables)

    }

}
