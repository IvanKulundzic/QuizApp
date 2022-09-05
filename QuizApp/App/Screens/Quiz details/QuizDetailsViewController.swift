import UIKit
import Combine

final class QuizDetailsViewController: UIViewController {

    private struct Constants {

        static let topMargin = 20
        static let horizontalMargin = 20

    }

    private let viewModel: QuizDetailsViewModel

    private var cancellables = Set<AnyCancellable>()

    private var leaderboardButton: UIButton!
    private var quizContainterView: UIView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var imageView: UIImageView!
    private var startButton: UIButton!

    init(viewModel: QuizDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleViews()
        defineLayoutForViews()
        setupNavigationBar()
        bindViewModel()
    }

}

extension QuizDetailsViewController: ConstructViewsProtocol {

    func createViews() {
        leaderboardButton = UIButton()
        view.addSubview(leaderboardButton)

        quizContainterView = UIView()
        view.addSubview(quizContainterView)

        titleLabel = UILabel()
        quizContainterView.addSubview(titleLabel)

        descriptionLabel = UILabel()
        quizContainterView.addSubview(descriptionLabel)

        imageView = UIImageView()
        quizContainterView.addSubview(imageView)

        startButton = UIButton()
        quizContainterView.addSubview(startButton)
    }

    func styleViews() {
        view.applyGradientWith([UIColor.loginBackgroundTop.cgColor, UIColor.loginBackgroundBottom.cgColor])

        let leaderboardTitle = NSAttributedString(
            string: "Leaderboard",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.font: Fonts.sourceSansProBold18.font]
        )
        leaderboardButton.setAttributedTitle(leaderboardTitle, for: .normal)
        leaderboardButton.addTarget(self, action: #selector(leaderboardButtonTapped), for: .touchUpInside)

        quizContainterView.backgroundColor = .white.withAlphaComponent(0.3)
        quizContainterView.layer.cornerRadius = 10

        titleLabel.style(color: .white, alignment: .center, font: Fonts.sourceSansProBold32.font)

        descriptionLabel.style(color: .white, alignment: .center, font: Fonts.sourceSansProSemiBold18.font)
        descriptionLabel.numberOfLines = 0

        imageView.style(contentMode: .scaleAspectFit, radius: 10)

        startButton.setTitle("Start Quiz", for: .normal)
        startButton.setTitleColor(.loginPurple, for: .normal)
        startButton.titleLabel?.font = Fonts.sourceSansProBold16.font
        startButton.layer.cornerRadius = 22
        startButton.backgroundColor = .white
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    func defineLayoutForViews() {
        leaderboardButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.topMargin)
            $0.trailing.equalTo(view.snp.trailing).inset(Constants.horizontalMargin)
            $0.width.height.equalTo(150)
        }

        quizContainterView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
            $0.height.equalTo(400)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalMargin)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.topMargin)
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalMargin)
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Constants.topMargin)
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalMargin)
            $0.height.equalTo(150)
        }

        startButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(Constants.topMargin)
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalMargin)
            $0.height.equalTo(44)
        }
    }

}

private extension QuizDetailsViewController {

    func setupNavigationBar() {
        title = "PopQuiz"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: Fonts.sourceSansProBold24.font]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
    }

    func bindViewModel() {
        viewModel
            .$quiz
            .sink { [weak self] quiz in
                guard let self = self else { return }

                self.setupViewFor(quiz: quiz)
            }
            .store(in: &cancellables)
    }

    func setupViewFor(quiz: QuizViewModel) {
        titleLabel.text = quiz.name
        descriptionLabel.text = quiz.description
        let imageUrl = URL(string: quiz.imageUrl)
        imageView.kf.setImage(with: imageUrl)
    }

    @objc func leaderboardButtonTapped() { }

    @objc func startButtonTapped() { }

}
