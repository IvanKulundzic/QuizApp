import UIKit
import SnapKit

final class LoginViewController: UIViewController {

    private var titleLabel: UILabel!
    private var emailTextField: InputField!
    private var passwordTextField: InputField!

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

}

// MARK: - ConstructViewsProtocol methods
extension LoginViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextField.isActive = true
            passwordTextField.isActive = false
        } else {
            emailTextField.isActive = false
            passwordTextField.isActive = true
        }
    }

}

// MARK: - ConstructViewsProtocol methods
extension LoginViewController: ConstructViewsProtocol {

    func createViews() {
        titleLabel = UILabel()
        view.addSubview(titleLabel)

        emailTextField = InputField()
        view.addSubview(emailTextField)
        emailTextField.delegate = self

        passwordTextField = InputField()
        view.addSubview(passwordTextField)
        passwordTextField.delegate = self
    }

    func styleViews() {
        view.applyGradientWith([UIColor.loginBackgroundTop.cgColor, UIColor.loginBackgroundBottom.cgColor])

        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = Fonts.sourceSansProBold32.font

        emailTextField.styleWith(.email)

        passwordTextField.styleWith(.password)
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(144)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(44)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(18)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(44)
        }
    }

}
