import UIKit

final class EmptyStateView: UIView {

    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!

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

extension EmptyStateView: ConstructViewsProtocol {

    func createViews() {
        imageView = UIImageView()
        addSubview(imageView)

        titleLabel = UILabel()
        addSubview(titleLabel)

        descriptionLabel = UILabel()
        addSubview(descriptionLabel)
    }

    func styleViews() {
        imageView.image = UIImage.errorIcon

        titleLabel.text = "Error"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = Fonts.sourceSansProBold28.font

        descriptionLabel.text = "Data can’t be reached.\nPlease try again"
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .white
        descriptionLabel.font = Fonts.sourceSansProRegular16.font
        descriptionLabel.numberOfLines = 0
    }

    func defineLayoutForViews() {
        imageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.width.height.equalTo(67)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(50)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(50)
        }
    }

}
