import UIKit
import Combine

final class ProgressView: UIView {

    private var progressViews: [UIView]!
    private var stackView: UIStackView!

    var questionNumber: Int = 1 {
        didSet {
            updateQuestion(for: questionNumber)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        progressViews = addViews()

        stackView = UIStackView()
        addSubview(stackView)
    }

    func styleViews() {
        progressViews.forEach {
            stackView.addArrangedSubview($0)
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

    func updateQuestion(for number: Int) {
        var current = 0

        while current < number {
            progressViews[current].backgroundColor = .white
            current += 1
        }
    }

    func addViews() -> [UIView] {
        let neededViews = 8
        var viewCount = 0
        var views: [UIView] = []

        while viewCount < neededViews {
            let view = UIView()
            views.append(view)
            viewCount += 1
        }

        return views
    }

}
