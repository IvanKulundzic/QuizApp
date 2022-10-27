import Combine
import UIKit

final class QuizSessionViewController: UIViewController {

    enum Constants {

        static let topMargin = 20
        static let horizontalMargin = 20

    }

    var score: Int = 0
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

    func setupNavigationBar() {
        title = "PopQuiz"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: Fonts.sourceSansProBold24.font]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
    }

    func display(question: QuestionViewModel) {
        guard let index = viewModel.questions.firstIndex(where: { $0.id == question.id }) else { return }

        questionNumberLabel.text = "\(index + 1)/\(viewModel.quiz.numberOfQuestions)"
        questionTextLabel.text = question.question
        progressView.questionNumber = index + 1

        createButtons(for: question, atIndex: index)
    }

    func createButtons(for question: QuestionViewModel, atIndex: Int) {
        buttonsCancellables = []

        buttonsStackView
            .subviews
            .forEach { $0.removeFromSuperview() }

        question
            .answers
            .forEach { answer in
                let answerViewState = AnswerViewState(id: answer.id, answer: answer.answer)
                let button = AnswerButton(withState: answerViewState)

                buttonsStackView.addArrangedSubview(button)

                button
                    .throttledTap()
                    .sink { [weak self] _ in
                        guard let self = self else { return }

                        let isCorrectAnswer = answer.id == question.correctAnswerId
                        button.backgroundColor = isCorrectAnswer ? .correctGreen : .incorrectRed

                        if !isCorrectAnswer {
                            self.markCorrectAnswer(correctAnswerId: question.correctAnswerId)
                        } else {
                            self.score += 1
                        }

                        self.updateProgressViews(for: isCorrectAnswer, atIndex: question.id - 1)
                        self.progressToNextQuestion(from: question)
                    }
                    .store(in: &buttonsCancellables)
            }

    }

    func updateProgressViews(for answer: Bool, atIndex: Int) {
        let subview = progressView.progressViews[atIndex]
        subview.backgroundColor = answer ? .correctGreen : .incorrectRed
    }

    func progressToNextQuestion(from question: QuestionViewModel) {
        guard
            let currentQuestion = viewModel.questions.firstIndex(where: { $0.id == question.id }),
            currentQuestion + 1 < viewModel.questions.count
        else {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
                guard let self = self else { return }

                let endSessionModel = EndSessionViewState(
                    sessionId: self.viewModel.sessionId,
                    score: self.score,
                    numberOfQuestions: self.viewModel.questions.count
                )
                self.viewModel.goToQuizResult(viewModel: endSessionModel)
            }
            return
        }

        let nextQuestion = viewModel.questions[currentQuestion + 1]

        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            guard let self = self else { return }

            self.display(question: nextQuestion)
        }
    }

    private func markCorrectAnswer(correctAnswerId: Int) {
        buttonsStackView
            .subviews
            .forEach { subview in
                guard
                    let answerButton = subview as? AnswerButton,
                    answerButton.viewState.id == correctAnswerId
                else { return }

                answerButton.backgroundColor = .correctGreen
            }
    }

}

struct EndSessionViewState {

    let sessionId: String
    let score: Int
    let numberOfQuestions: Int

}
