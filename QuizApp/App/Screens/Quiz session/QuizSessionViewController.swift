import Combine
import UIKit

final class QuizSessionViewController: UIViewController {

    enum Constants {

        static let topMargin = 20
        static let horizontalMargin = 20

    }

    @Published private var isCorrect: Bool?
    @Published private var questionNumber = 1
    private var cancellables = Set<AnyCancellable>()
    private var buttonsCancellables = Set<AnyCancellable>()

    private var questionNumberLabel: UILabel!
    private var progressView: ProgressView!
    private var questionTextLabel: UILabel!
    private var buttonsStackView: UIStackView!
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
        guard questionNumber <= viewModel.questions.count else { return }

        let answers = viewModel.questions[questionNumber - 1].answers

        buttonsStackView.subviews.forEach { view in
            buttonsStackView.removeArrangedSubview(view)
        }

        answers.forEach { answer in
            let button = UIButton()
            configureButton(button: button, title: answer.answer)

            button
                .throttledTap()
                .sink { [weak self] in
                    guard let self = self else { return }

                    guard self.questionNumber <= self.viewModel.questions.count else { return }

                    let tappedAnswerId = answer.id
                    let correctAnswerId = self.viewModel.questions[self.questionNumber - 1].correctAnswerId

                    self.evaluateAnswer(answerId: tappedAnswerId, correctId: correctAnswerId)

                    if let isCorrect = self.isCorrect {
                        button.backgroundColor = isCorrect ? .correctGreen: .incorrectRed
                    }

                    _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                        self.questionNumber += 1
                        self.setupButtons()
                    }
                }
                .store(in: &buttonsCancellables)
        }
    }

    func configureButton(button: UIButton, title: String) {
        button.backgroundColor = .white.withAlphaComponent(0.3)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Fonts.sourceSansProBold20.font
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        button.layer.cornerRadius = 24
        buttonsStackView.addArrangedSubview(button)
    }

    func evaluateAnswer(answerId: Int, correctId: Int) {
        isCorrect = answerId == correctId ? true : false
    }

    func addSubscription() {
        $questionNumber
            .sink { [weak self] value in
                guard let self = self else { return }

                guard value <= self.viewModel.questions.count else { return }

                let quiz = self.viewModel.quiz
                let question = self.viewModel.questions[value - 1].question
                self.questionNumberLabel.text = "\(value)/\(quiz.numberOfQuestions)"
                self.questionTextLabel.text = "\(question)"
                self.progressView.questionNumber = value
            }
            .store(in: &cancellables)

        $isCorrect
            .sink { value in
                guard let value = value else { return }

                self.updateViews(for: value)
            }
            .store(in: &cancellables)
    }

    func updateViews(for answer: Bool) {
        let progressSubview = progressView.progressViews[questionNumber - 1]

        switch answer {
        case true:
            progressSubview.backgroundColor = .correctGreen
        case false:
            progressSubview.backgroundColor = .incorrectRed
        }
    }

    @MainActor
    func startSession() {
        Task {
            await viewModel.getQuestions()
            addSubscription()
            setupButtons()
        }
    }

}
