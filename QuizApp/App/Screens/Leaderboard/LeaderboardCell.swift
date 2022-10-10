import UIKit

final class LeaderboardCell: UITableViewCell {

    static let reuseIdentifier = String(describing: LeaderboardCell.self)

    private var nameLabel: UILabel!
    private var pointsLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(for leaderboard: LeaderboardModel, index: Int) {
        let playerPosition = "\(index + 1). "
        let attributedString = NSAttributedString(
            string: playerPosition,
            attributes: [
                NSAttributedString.Key.font: Fonts.sourceSansProBold20.font,
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        )
        let attributedLeaderboardString = NSAttributedString(string: leaderboard.name)

        nameLabel.attributedText = combine(left: attributedString, right: attributedLeaderboardString)
        pointsLabel.text = leaderboard.points
    }

}

extension LeaderboardCell: ConstructViewsProtocol {

    func createViews() {
        nameLabel = UILabel()
        addSubview(nameLabel)

        pointsLabel = UILabel()
        addSubview(pointsLabel)
    }

    func styleViews() {
        backgroundColor = .clear

        nameLabel.style(with: "test", color: .white, alignment: .left, font: Fonts.sourceSansProSemiBold18.font)

        pointsLabel.style(with: "12345", color: .white, alignment: .left, font: Fonts.sourceSansProSemiBold18.font)
    }

    func defineLayoutForViews() {
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview()
        }

        pointsLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }

}

private extension LeaderboardCell {

    func combine(left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }

}
