import UIKit

struct AnswerViewState {

    let id: Int
    let answer: String

}

final class AnswerButton: UIButton {

    private(set) var viewState: AnswerViewState!

    convenience init(withState viewState: AnswerViewState) {
        self.init()

        self.viewState = viewState
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
        setTitle(viewState.answer, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = Fonts.sourceSansProBold20.font
        contentHorizontalAlignment = .left
        titleEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        layer.cornerRadius = 24
    }

    func defineLayoutForViews() {}

}
