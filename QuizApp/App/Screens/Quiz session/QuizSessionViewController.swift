import Combine
import UIKit

final class QuizSessionViewController: UIViewController {

    enum Constants {

        static let topMargin = 20
        static let horizontalMargin = 20

    }

    private var questionNumber = CurrentValueSubject<Int, Never>(1)
    private var cancellables = Set<AnyCancellable>()

    private var questionNumberLabel: UILabel!
    private var progressView: ProgressView!
    private var questionTextLabel: UILabel!
    private var buttonsStackView: UIStackView!
    private var buttons: [UIButton]!
    private var viewModel: QuizSessionViewModel!

    init(viewModel: QuizSessionViewModel) {
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
        startSession()
    }

}

extension QuizSessionViewController: ConstructViewsProtocol {

    func createViews() {
        questionNumberLabel = UILabel()
        view.addSubview(questionNumberLabel)

        progressView = ProgressView(numberOfQuestions: viewModel.quiz.numberOfQuestions)
        view.addSubview(progressView)

        questionTextLabel = UILabel()
        view.addSubview(questionTextLabel)

        buttonsStackView = UIStackView()
        view.addSubview(buttonsStackView)

        buttons = [
            UIButton(),
            UIButton(),
            UIButton(),
            UIButton()
        ]
    }

    func styleViews() {
        view.applyGradientWith([UIColor.loginBackgroundTop.cgColor, UIColor.loginBackgroundBottom.cgColor])

        questionNumberLabel.style(color: .white, alignment: .left, font: Fonts.sourceSansProBold18.font)

        questionTextLabel.style(color: .white, alignment: .left, font: Fonts.sourceSansProBold24.font)
        questionTextLabel.numberOfLines = 0

        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 16
        buttonsStackView.axis = .vertical
    }

    @objc func buttonTapped(sender: UIButton) {

    }

    func defineLayoutForViews() {
        questionNumberLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalMargin)
            $0.height.equalTo(25)
        }

        progressView.snp.makeConstraints {
            $0.top.equalTo(questionNumberLabel.snp.bottom).offset(11)
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalMargin)
            $0.height.equalTo(5)
        }

        questionTextLabel.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(54)
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalMargin)
        }

        buttonsStackView.snp.makeConstraints {
            $0.top.equalTo(questionTextLabel.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalMargin)
            $0.height.equalTo(250)
        }
    }

}

private extension QuizSessionViewController {

    func setupNavigationBar() {
        title = "PopQuiz"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: Fonts.sourceSansProBold24.font]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
    }

    func setupButtons() {
        var tag = 0
        var answer = 0

        buttons.forEach {
            buttonsStackView.addArrangedSubview($0)
            $0.backgroundColor = .white.withAlphaComponent(0.3)
            let title = viewModel.questions[questionNumber.value - 1].answers[answer].answer
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = Fonts.sourceSansProBold20.font
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
            $0.layer.cornerRadius = 24
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            $0.tag = tag
            tag += 1
            answer += 1
        }
    }

    func addSubscription() {
        questionNumber
            .sink { [weak self] _ in
                guard let self = self else { return }

                let quiz = self.viewModel.quiz
                let question = self.viewModel.questions[self.questionNumber.value - 1].question
                self.questionNumberLabel.text = "\(self.questionNumber.value)/\(quiz.numberOfQuestions)"
                self.questionTextLabel.text = "\(question)"
                self.progressView.questionNumber = self.questionNumber.value
            }
            .store(in: &cancellables)
    }

    @MainActor
    func startSession() {
        Task {
            await viewModel.getQuestions()
            setupButtons()
            addSubscription()
        }
    }

}
