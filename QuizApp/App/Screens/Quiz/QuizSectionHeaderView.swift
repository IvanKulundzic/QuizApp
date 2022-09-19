import UIKit

final class QuizSectionHeaderView: UICollectionReusableView {

    static let reuseIdentifier = String(describing: QuizSectionHeaderView.self)

    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(for category: CategoryViewModel) {
        titleLabel.text = category.rawValue
    }

}

extension QuizSectionHeaderView: ConstructViewsProtocol {

    func createViews() {
        titleLabel = UILabel()
        addSubview(titleLabel)
    }

    func styleViews() {
        titleLabel.style(color: .white, alignment: .left, font: Fonts.sourceSansProBold20.font)
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
