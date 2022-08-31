import UIKit
import Kingfisher

final class QuizCell: UICollectionViewCell {

    struct Constants {

        static let imageViewInset = 20
        static let titleLabelHeight = 25
        static let descriptionLabelInset = 20
        static let descriptionLabelWidth = 200

    }

    static let reuseIdentifier = String(describing: QuizCell.self)

    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var difficultyView: DifficultyView!

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

extension QuizCell {

    func set(for quiz: QuizViewModel) {
        titleLabel.text = quiz.category.rawValue
        descriptionLabel.text = quiz.description
        let imageUrl = URL(string: quiz.imageUrl)
        imageView.kf.setImage(with: imageUrl)
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

        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true

        titleLabel.textColor = .white
        titleLabel.font = Fonts.sourceSansProBold24.font

        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = Fonts.sourceSansProSemiBold14.font
    }

    func defineLayoutForViews() {
        imageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Constants.imageViewInset)
            $0.width.equalTo(103)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.leading.equalTo(imageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(Constants.titleLabelHeight)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(imageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }

        difficultyView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(20)
            $0.width.equalTo(50)
        }
    }

}
