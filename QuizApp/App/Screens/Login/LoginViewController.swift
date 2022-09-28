import UIKit
import SnapKit
import Combine
import Factory

final class LoginViewController: UIViewController {

    @Injected(LoginContainer.loginViewModel) private var loginViewModel

    private var titleLabel: UILabel!
    private var emailInputField: InputField!
    private var passwordInputField: InputField!
    private var loginButton: UIButton!
    private var errorLabel: UILabel!
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleViews()
        defineLayoutForViews()
        bindViewModel()
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

    func textFieldDidChangeSelection(_ textField: UITextField) {
        let username = emailInputField.text ?? ""
        let password = passwordInputField.text ?? ""
        loginViewModel.validate(username: username, password: password)
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

        errorLabel = UILabel()
        view.addSubview(errorLabel)
        errorLabel.isHidden = true
    }

    func styleViews() {
        view.applyGradientWith([UIColor.loginBackgroundTop.cgColor, UIColor.loginBackgroundBottom.cgColor])

        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = Fonts.sourceSansProBold32.font

        loginButton.layer.cornerRadius = 20
        loginButton.isEnabled = false
        let titleString = NSAttributedString(
            string: "Login",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.loginPurple,
                NSAttributedString.Key.font: Fonts.sourceSansProBold16.font]
        )
        loginButton.setAttributedTitle(titleString, for: .normal)

        errorLabel.textColor = .red
        errorLabel.textAlignment = .left
        errorLabel.font = Fonts.sourceSansProSemiBold16.font
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
            $0.top.equalTo(passwordInputField.snp.bottom).offset(30)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(44)
        }

        errorLabel.snp.makeConstraints {
            $0.top.equalTo(passwordInputField.snp.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(45)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(45)
            $0.height.equalTo(25)
        }
    }

    func bindViewModel() {
        loginViewModel
            .$errorMessage
            .sink { error in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = error
                }

            }
            .store(in: &cancellables)

        loginViewModel
            .$isLoginButtonEnabled
            .sink { isEnabled in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.loginButton.isEnabled = isEnabled
                    self.loginButton.backgroundColor = isEnabled ? .white : .white.withAlphaComponent(0.6)
                }
            }
            .store(in: &cancellables)
    }

    @objc func loginButtonTapped() {
        let password = passwordInputField.text ?? ""
        let username = emailInputField.text ?? ""
        loginViewModel.loginUser(password: password, username: username)
    }

}
