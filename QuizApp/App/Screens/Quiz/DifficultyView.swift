import UIKit

final class DifficultyView: UIView {

    enum Difficulty {

        case easy
        case medium
        case hard

    }

    var type: Difficulty = .easy

    private var stackView: UIStackView!
    private var rectangleOne: UIImageView!
    private var rectangleTwo: UIImageView!
    private var rectangleThree: UIImageView!

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

// MARK: - ConstructViewsProtocol methods
extension DifficultyView: ConstructViewsProtocol {

    func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        rectangleOne = UIImageView()
        stackView.addArrangedSubview(rectangleOne)

        rectangleTwo = UIImageView()
        stackView.addArrangedSubview(rectangleTwo)

        rectangleThree = UIImageView()
        stackView.addArrangedSubview(rectangleThree)
    }

    func styleViews() {
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .equalSpacing

        rectangleOne.contentMode = .scaleAspectFit
        rectangleTwo.contentMode = .scaleAspectFit
        rectangleThree.contentMode = .scaleAspectFit

        updateImages()
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

// MARK: - Private methods
private extension DifficultyView {

    func updateImages() {
        switch type {
        case .easy:
            rectangleOne.image = UIImage.rectangleOrange
            rectangleTwo.image = UIImage.rectangleWhite
            rectangleThree.image = UIImage.rectangleWhite
        case .medium:
            rectangleOne.image = UIImage.rectangleOrange
            rectangleTwo.image = UIImage.rectangleOrange
            rectangleThree.image = UIImage.rectangleWhite
        case .hard:
            rectangleOne.image = UIImage.rectangleOrange
            rectangleTwo.image = UIImage.rectangleOrange
            rectangleThree.image = UIImage.rectangleOrange
        }
    }

}
