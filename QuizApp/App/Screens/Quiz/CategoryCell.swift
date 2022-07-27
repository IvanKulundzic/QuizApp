import UIKit

final class CategoryCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: CategoryCell.self)

    private var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CategoryCell {

    func set(for category: Category) {
        titleLabel.text = category.type.rawValue
        titleLabel.textColor = category.color
    }

}

// MARK: - ConstructViewsProtocol methods
extension CategoryCell: ConstructViewsProtocol {

    func createViews() {
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
    }

    func styleViews() {
        contentView.backgroundColor = .clear

        titleLabel.font = Fonts.sourceSansProBold16.font
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }

}
