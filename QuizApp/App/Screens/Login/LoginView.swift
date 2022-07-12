import UIKit
import SnapKit

final class LoginView: UIView {

    private lazy var titleLabel = UILabel()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - ConstructViewsProtocol methods
extension LoginView: ConstructViewsProtocol {

    func setupView() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        addSubview(titleLabel)
    }

    func styleViews() {
        backgroundColor = Colors.loginBackground.color

        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.font = Fonts.sourceSansProBold32.font
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.top.equalTo(safeAreaLayoutGuide).offset(80)
        }
    }

}
