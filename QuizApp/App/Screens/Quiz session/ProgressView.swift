import Combine
import UIKit

final class ProgressView: UIView {

    private(set) var progressViews: [UIView]!
    private var stackView: UIStackView!
    private var numberOfQuestions: Int

    var questionNumber: Int = 1 {
        didSet {
            setColor(for: questionNumber)
        }
    }

    required init(numberOfQuestions: Int) {
        self.numberOfQuestions = numberOfQuestions
        super.init(frame: .zero)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ProgressView: ConstructViewsProtocol {

    func createViews() {
        progressViews = generateViews()

        stackView = UIStackView()
        addSubview(stackView)

        progressViews.forEach {
            stackView.addArrangedSubview($0)
        }
    }

    func styleViews() {
        progressViews.forEach {
            $0.backgroundColor = .white.withAlphaComponent(0.3)
            $0.layer.cornerRadius = 3
        }

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

private extension ProgressView {

    func setColor(for index: Int) {
        progressViews[index - 1].backgroundColor = .white
    }

    func generateViews() -> [UIView] {
        var views: [UIView] = []

        for _ in 1...numberOfQuestions {
            let view = UIView()
            views.append(view)
        }

        return views
    }

}
