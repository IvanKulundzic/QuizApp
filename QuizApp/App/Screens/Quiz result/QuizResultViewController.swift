import UIKit

final class QuizResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
    }

}

extension QuizResultViewController: ConstructViewsProtocol {

    func createViews() {}

    func styleViews() {
        view.applyGradientWith([UIColor.loginBackgroundTop.cgColor, UIColor.loginBackgroundBottom.cgColor])
    }

    func defineLayoutForViews() {}

}
