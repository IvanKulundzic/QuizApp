import UIKit

final class QuizCell: UICollectionViewCell {

    var data: Category? {
        didSet {
            guard let data = data else { return }
            update(data: data)
        }
    }

    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var difficultyView: DifficultyView!
    static let reuseIdentifier = "QuizCell"

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
extension QuizCell: ConstructViewsProtocol {

    func createViews() {
        imageView = UIImageView()
        contentView.addSubview(imageView)

        titleLabel = UILabel()
        contentView.addSubview(titleLabel)

        descriptionLabel = UILabel()
        contentView.addSubview(descriptionLabel)

        difficultyView = DifficultyView()
        contentView.addSubview(difficultyView)
    }

    func styleViews() {
        contentView.backgroundColor = .white.withAlphaComponent(0.3)
        contentView.layer.cornerRadius = 20

        imageView.image = UIImage(named: "imgSport")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .yellow
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true

        titleLabel.textColor = .white
        titleLabel.font = Fonts.sourceSansProBold24.font

        descriptionLabel.text = "Quiz description that can\nusually span over multiple \nlines"
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = Fonts.sourceSansProSemiBold14.font
    }

    func defineLayoutForViews() {
        imageView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            $0.width.equalTo(103)
            $0.height.equalTo(103)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(25)
            $0.leading.equalTo(imageView.snp.trailing).offset(15)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(imageView.snp.trailing).offset(15)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }

        difficultyView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(20)
            $0.width.equalTo(70)
        }
    }

}

// MARK: - Private methods
private extension QuizCell {

    func update(data: Category) {
        titleLabel.text = data.name
    }

}
