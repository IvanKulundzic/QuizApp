import UIKit
import SnapKit

final class LoginViewController: UIViewController {

    private var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleViews()
        defineLayoutForViews()
    }

}

// MARK: - ConstructViewsProtocol methods
extension LoginViewController: ConstructViewsProtocol {

    func createViews() {
        titleLabel = UILabel()
        view.addSubview(titleLabel)
    }

    func styleViews() {
        view.backgroundColor = Colors.loginBackground.color

        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = Fonts.sourceSansProBold32.font
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
    }

}
