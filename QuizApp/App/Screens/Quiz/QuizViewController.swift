import UIKit

final class QuizViewController: UIViewController {

    private var getQuizButton: UIButton!
    private var emptyStateView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleViews()
        defineLayoutForViews()
        setupTabBar()
    }

}

// MARK: - ConstructViewsProtocol methods
extension QuizViewController: ConstructViewsProtocol {

    func createViews() {
        getQuizButton = UIButton()
        view.addSubview(getQuizButton)

        emptyStateView = EmptyStateView()
        view.addSubview(emptyStateView)
    }

    func styleViews() {
        view.applyGradientWith([UIColor.loginBackgroundTop.cgColor, UIColor.loginBackgroundBottom.cgColor])
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: Fonts.sourceSansProBold24.font
        ]

        getQuizButton.setTitle("Get Quiz", for: .normal)
        getQuizButton.setTitleColor(.loginPurple, for: .normal)
        getQuizButton.titleLabel?.tintColor = .loginPurple
        getQuizButton.titleLabel?.font = Fonts.sourceSansProBold16.font
        getQuizButton.backgroundColor = .white
        getQuizButton.layer.cornerRadius = 20

        emptyStateView.isHidden = false
    }

    func defineLayoutForViews() {
        getQuizButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(35)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(311)
            $0.height.equalTo(44)
        }

        emptyStateView.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
            $0.width.equalTo(250)
        }
    }

    func setupTabBar() {
        let titleLabel = UILabel()
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.font = Fonts.sourceSansProBold24.font

        tabBarController?.navigationItem.titleView = titleLabel

        tabBarItem.title = "Quiz"
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        tabBarItem.image = UIImage.quizIcon?.withRenderingMode(.alwaysTemplate)
    }

}
