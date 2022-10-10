import Combine
import UIKit

final class QuizSessionViewController: UIViewController {

    enum Constants {

        static let topMargin = 20
        static let horizontalMargin = 20

    }

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

    @MainActor
    func startSession() {
        Task {
            await viewModel.getQuestions()

            let firstQuestion = viewModel.questions[0]
            display(question: firstQuestion)
        }
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

    private func setupNavigationBar() {
        title = "PopQuiz"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: Fonts.sourceSansProBold24.font]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
    }

    private func display(question: QuestionViewModel) {
        guard let index = viewModel.questions.firstIndex(where: { $0.id == question.id }) else { return }

        questionNumberLabel.text = "\(index + 1)/\(viewModel.quiz.numberOfQuestions)"
        questionTextLabel.text = question.question
        progressView.questionNumber = index + 1

        createButtons(for: question, atIndex: index)
    }

    private func createButtons(for question: QuestionViewModel, atIndex questionIndex: Int) {
        buttonsCancellables = []

        buttonsStackView
            .subviews
            .forEach { $0.removeFromSuperview() }

        question
            .answers
            .forEach { answer in
                let answerViewModel = AnswerViewModel(id: answer.id, answer: answer.answer)
                let answerButton = AnswerButton(withAnswer: answerViewModel)
                buttonsStackView.addArrangedSubview(answerButton)

                answerButton
                    .throttledTap()
                    .sink { [weak self] _ in
                        guard let self = self else { return }

                        let answeredCorrectly = answer.id == question.correctAnswerId
                        answerButton.backgroundColor = answeredCorrectly ? .correctGreen : .incorrectRed

                        self.updateProgressView(at: questionIndex, answeredCorrectly: answeredCorrectly)

                        if !answeredCorrectly {
                            self.markCorrectAnswer(correctAnswerId: question.correctAnswerId)
                        }

                        self.progressToNextQuestion(from: question)
                    }
                    .store(in: &buttonsCancellables)
            }
    }

    private func updateProgressView(at index: Int, answeredCorrectly: Bool) {
        let progressSubview = progressView.progressViews[index]
        progressSubview.backgroundColor = answeredCorrectly ? .correctGreen : .incorrectRed
    }

    private func progressToNextQuestion(from question: QuestionViewModel) {
        guard
            let currentIndex = viewModel.questions.firstIndex(where: { $0.id == question.id }),
            currentIndex + 1 < viewModel.questions.count
        else {
            //finish quiz
            return
        }

        let nextQuestion = viewModel.questions[currentIndex + 1]

        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            self?.display(question: nextQuestion)
        }
    }

    private func markCorrectAnswer(correctAnswerId: Int) {
        buttonsStackView
            .subviews
            .forEach { subview in
                guard
                    let answerButton = subview as? AnswerButton,
                    answerButton.viewModel.id == correctAnswerId
                else { return }

                answerButton.backgroundColor = .correctGreen
            }
    }

}

struct AnswerViewModel {

    let id: Int
    let answer: String

}

class AnswerButton: UIButton {

    private(set) var viewModel: AnswerViewModel!

    convenience init(withAnswer viewModel: AnswerViewModel) {
        self.init()

        self.viewModel = viewModel
        buildViews()
    }

}

extension AnswerButton: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {}

    func styleViews() {
        backgroundColor = .white.withAlphaComponent(0.3)
        setTitle(viewModel.answer, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = Fonts.sourceSansProBold20.font
        contentHorizontalAlignment = .left
        titleEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        layer.cornerRadius = 24
    }

    func defineLayoutForViews() {}
}
