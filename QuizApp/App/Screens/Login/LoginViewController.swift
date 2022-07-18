import UIKit
import SnapKit
import Combine

final class LoginViewController: UIViewController {

    private var titleLabel: UILabel!
    private var emailInputField: InputField!
    private var passwordInputField: InputField!
    private var loginButton: UIButton!
    private var cancellables = Set<AnyCancellable>()
    private let loginViewModel: LoginViewModel

    // MARK: - Init

    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleViews()
        defineLayoutForViews()
        addCallbacks()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

}

// MARK: - ConstructViewsProtocol methods
extension LoginViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailInputField {
            emailInputField.isActive = true
            passwordInputField.isActive = false
        } else {
            emailInputField.isActive = false
            passwordInputField.isActive = true
        }
    }

}

// MARK: - ConstructViewsProtocol methods
extension LoginViewController: ConstructViewsProtocol {

    func createViews() {
        titleLabel = UILabel()
        view.addSubview(titleLabel)

        emailInputField = InputField(type: .email)
        view.addSubview(emailInputField)
        emailInputField.delegate = self

        passwordInputField = InputField(type: .password)
        view.addSubview(passwordInputField)
        passwordInputField.delegate = self

        loginButton = UIButton()
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    func styleViews() {
        view.applyGradientWith([UIColor.loginBackgroundTop.cgColor, UIColor.loginBackgroundBottom.cgColor])

        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = Fonts.sourceSansProBold32.font

        loginButton.layer.cornerRadius = 20
        loginButton.isEnabled = true
        loginButton.backgroundColor = loginButton.isEnabled ? .white : .white.withAlphaComponent(0.6)
        let titleString = NSAttributedString(
            string: "Login",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.loginButtonTitle,
                NSAttributedString.Key.font: Fonts.sourceSansProBold16.font]
        )
        loginButton.setAttributedTitle(titleString, for: .normal)
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }

        emailInputField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(144)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(44)
        }

        passwordInputField.snp.makeConstraints {
            $0.top.equalTo(emailInputField.snp.bottom).offset(18)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(44)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordInputField.snp.bottom).offset(18)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(44)
        }
    }

    func addCallbacks() {
        loginViewModel
            .$errorLoggingIn
            .sink { error in
                print("Error logging in: \(error)")
            }
            .store(in: &cancellables)
    }

    @objc func loginButtonTapped() {
        Task(priority: .background) {
            let password = passwordInputField.text ?? ""
            let username = emailInputField.text ?? ""
            await loginViewModel.loginUser(password: password, username: username)
        }
    }

}
