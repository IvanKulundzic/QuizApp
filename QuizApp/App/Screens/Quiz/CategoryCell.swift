import UIKit

final class CategoryCell: UICollectionViewCell {

    var data: Category? {
        didSet {
            guard let data = data else { return }
            update(data: data)
        }
    }

    override var isSelected: Bool {
        didSet {
            updateTextColor()
        }
    }

    private var titleLabel: UILabel!
    static let reuseIdentifier = "CategoryCell"

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

// MARK: - ConstructViewsProtocol methods
extension CategoryCell: ConstructViewsProtocol {

    func createViews() {
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
    }

    func styleViews() {
        contentView.backgroundColor = .clear

        titleLabel.textColor = .white
        titleLabel.font = Fonts.sourceSansProBold16.font
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.center.equalTo(contentView.safeAreaLayoutGuide)
        }
    }

}

// MARK: - Private methods
private extension CategoryCell {

    func update(data: Category) {
        titleLabel.text = data.name
    }

    func updateTextColor() {
        titleLabel.textColor = isSelected ? .orange : .white
    }

}
