import UIKit

final class LoginViewController: UIViewController {

    private lazy var loginView = LoginView()

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
