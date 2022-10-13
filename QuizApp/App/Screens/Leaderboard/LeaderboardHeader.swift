import UIKit

final class LeaderboardHeader: UITableViewHeaderFooterView {

    static let reuseIdentifier = String(describing: LeaderboardHeader.self)

    private var nameLabel: UILabel!
    private var pointsLabel: UILabel!

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LeaderboardHeader: ConstructViewsProtocol {

    func createViews() {
        nameLabel = UILabel()
        contentView.addSubview(nameLabel)

        pointsLabel = UILabel()
        contentView.addSubview(pointsLabel)
    }

    func styleViews() {
        nameLabel.style(with: "Player", color: .white, alignment: .left, font: Fonts.sourceSansProSemiBold16.font)

        pointsLabel.style(with: "Points", color: .white, alignment: .left, font: Fonts.sourceSansProSemiBold16.font)
    }

    func defineLayoutForViews() {
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(10)
        }

        pointsLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
    }

}
