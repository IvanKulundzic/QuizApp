import Combine
import UIKit

final class QuizResultViewController: UIViewController {

    private var endSessionViewModel: EndSessionViewModel
    private var cancellables = Set<AnyCancellable>()
    private var resultLabel: UILabel!
    private var finishQuizButton: AnswerButton!
    private let viewModel: QuizResultViewModel

    init(endSessionViewModel: EndSessionViewModel, viewModel: QuizResultViewModel) {
        self.endSessionViewModel = endSessionViewModel
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
        styleNavigationBar()
    }

}

extension QuizResultViewController: ConstructViewsProtocol {

    func createViews() {
        resultLabel = UILabel()
        view.addSubview(resultLabel)

        finishQuizButton = AnswerButton()
        view.addSubview(finishQuizButton)
    }

    func styleViews() {
        view.applyGradientWith([UIColor.loginBackgroundTop.cgColor, UIColor.loginBackgroundBottom.cgColor])

        resultLabel.style(
            with: "\(endSessionViewModel.score)/\(endSessionViewModel.numberOfQuestions)",
            color: .white,
            alignment: .center,
            font: Fonts.sourceSansProBold88.font
        )

        finishQuizButton.backgroundColor = .white
        finishQuizButton.setTitle("Finish Quiz", for: .normal)
        finishQuizButton.setTitleColor(.loginPurple, for: .normal)
        finishQuizButton.titleLabel?.font = Fonts.sourceSansProBold16.font
        finishQuizButton.contentHorizontalAlignment = .center
        finishQuizButton.layer.cornerRadius = 24

        finishQuizButton
            .throttledTap()
            .sink { [weak self] in
                guard let self = self else { return }

                self.viewModel.endQuizSession(
                    for: self.endSessionViewModel.sessionId,
                    correctQuestions: self.endSessionViewModel.score
                )
            }
            .store(in: &cancellables)
    }

    func defineLayoutForViews() {
        resultLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        finishQuizButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(296)
            $0.height.equalTo(44)
        }
    }

}

private extension QuizResultViewController {

    func styleNavigationBar() {
        navigationItem.hidesBackButton = true
    }

}
