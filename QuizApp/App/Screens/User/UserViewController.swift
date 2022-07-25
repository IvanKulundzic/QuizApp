import UIKit
import Combine

final class UserViewController: UIViewController {

    private var usernameLabel: UILabel!
    private var usernameTextLabel: UILabel!
    private var nameLabel: UILabel!
    private var nameTextField: UITextField!
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
        addTapGesture()
    }

}

// MARK: - ConstructViewsProtocol methods
extension UserViewController: ConstructViewsProtocol {

    func createViews() {
        usernameLabel = UILabel()
        view.addSubview(usernameLabel)

        usernameTextLabel = UILabel()
        view.addSubview(usernameTextLabel)

        nameLabel = UILabel()
        view.addSubview(nameLabel)

        nameTextField = UITextField()
        view.addSubview(nameTextField)

        logoutButton = UIButton()
        view.addSubview(logoutButton)
    }

    func styleViews() {
        view.applyGradientWith([UIColor.loginBackgroundTop.cgColor, UIColor.loginBackgroundBottom.cgColor])

        usernameLabel.text = "USERNAME"
        usernameLabel.textColor = .white
        usernameLabel.textAlignment = .left
        usernameLabel.font = Fonts.sourceSansProSemiBold12.font

        usernameTextLabel.textColor = .white
        usernameTextLabel.textAlignment = .left
        usernameTextLabel.font = Fonts.sourceSansProBold20.font

        nameLabel.text = "NAME"
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.font = Fonts.sourceSansProSemiBold12.font

        nameTextField.textColor = .white
        nameTextField.font = Fonts.sourceSansProBold20.font

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

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(usernameTextLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
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
            .sink { [weak self] username in
                guard let self = self else { return }
                self.usernameTextLabel.text = username
            }
            .store(in: &cancellables)

        userViewModel
            .$name
            .sink { [weak self] name in
                guard let self = self else { return }
                self.nameTextField.text = name
            }
            .store(in: &cancellables)

        userViewModel
            .errorMessage
            .sink { [weak self] error in
                guard let self = self else { return }
                self.showAlert(with: error)
            }
            .store(in: &cancellables)

    }

    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }

    @objc func handleTap() {
        guard let name = nameTextField.text else { return }
        userViewModel.update(name)
        nameTextField.resignFirstResponder()
    }

    func showAlert(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
                guard let self = self else { return }
                self.dismiss(animated: true)
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }

}
