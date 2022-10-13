import Combine
import UIKit

final class LeaderboardViewController: UIViewController {

    private var leaderboradTableView: UITableView!
    private var cancellables = Set<AnyCancellable>()
    private var buttonsCancellables = Set<AnyCancellable>()
    private var viewModel: LeaderboardViewModel

    init(viewModel: LeaderboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.fetchLeaderboard()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
        addTableViewDelegateAndDatasource()
        bindViewModel()
        setupNavigationBar()
    }

}

extension LeaderboardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.leaderboardEntries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LeaderboardCell.reuseIdentifier,
                for: indexPath) as? LeaderboardCell
        else { return UITableViewCell() }

        cell.layoutMargins = .zero
        cell.preservesSuperviewLayoutMargins = false

        cell.set(for: viewModel.leaderboardEntries[indexPath.row], index: indexPath.row)

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: LeaderboardHeader.reuseIdentifier)
        return view
    }

}

extension LeaderboardViewController: UITableViewDelegate { }

extension LeaderboardViewController: ConstructViewsProtocol {

    func createViews() {
        leaderboradTableView = UITableView()
        view.addSubview(leaderboradTableView)

        leaderboradTableView.register(LeaderboardCell.self, forCellReuseIdentifier: LeaderboardCell.reuseIdentifier )
        leaderboradTableView.register(
            LeaderboardHeader.self,
            forHeaderFooterViewReuseIdentifier: LeaderboardHeader.reuseIdentifier
        )
    }

    func styleViews() {
        view.applyGradientWith([UIColor.loginBackgroundTop.cgColor, UIColor.loginBackgroundBottom.cgColor])

        leaderboradTableView.backgroundColor = .clear
        leaderboradTableView.rowHeight = 63
        leaderboradTableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        leaderboradTableView.separatorColor = .white
        leaderboradTableView.estimatedSectionHeaderHeight = 50
    }

    func defineLayoutForViews() {
        leaderboradTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }

}

private extension LeaderboardViewController {

    func addTableViewDelegateAndDatasource() {
        leaderboradTableView.dataSource = self
        leaderboradTableView.delegate = self
    }

    func bindViewModel() {
        viewModel
            .$leaderboardEntries
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.leaderboradTableView.reloadData()
            }
            .store(in: &cancellables)
    }

    func setupNavigationBar() {
        title = "Leaderboard"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: Fonts.sourceSansProBold24.font]
        navigationController?.navigationBar.tintColor = .white
        navigationItem.setHidesBackButton(true, animated: false)

        let closeBarButton = UIBarButtonItem(
            image: UIImage.closeIcon,
            style: .plain,
            target: self,
            action: nil
        )

        closeBarButton
            .tap
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.viewModel.closeLeaderboard()
            }
            .store(in: &buttonsCancellables)

        navigationItem.rightBarButtonItem = closeBarButton
    }

}
