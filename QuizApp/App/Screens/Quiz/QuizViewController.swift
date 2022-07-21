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

        let titleString = NSAttributedString(
            string: "Get Quiz",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.loginButtonTitle,
                NSAttributedString.Key.font: Fonts.sourceSansProBold16.font]
        )
        getQuizButton.setAttributedTitle(titleString, for: .normal)
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
        tabBarItem.title = "Quiz"
        tabBarItem.image = UIImage(named: "icnQuiz")?.withRenderingMode(.alwaysOriginal)
    }

}
