import Combine

final class LeaderboardViewModel {

    @Published var leaderboardEntries: [LeaderboardModel] = []
    private var coordinator: CoordinatorProtocol

    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func fetchLeaderboard() {
        let results = [
            LeaderboardModel(name: "Ivan Ivan Ivan Ivan Ivan Ivan Ivan Ivan Ivan Ivan Ivan Ivan", points: "5000"),
            LeaderboardModel(name: "Kiki", points: "4312"),
            LeaderboardModel(name: "MarinM", points: "1890"),
            LeaderboardModel(name: "Marin", points: "2450"),
            LeaderboardModel(name: "Igor", points: "3210"),
            LeaderboardModel(name: "Dora", points: "9999"),
            LeaderboardModel(name: "Šime", points: "2765"),
            LeaderboardModel(name: "Antonio", points: "1")
        ]
        let sorted = results.sorted { $0.points > $1.points }
        leaderboardEntries = sorted
    }

    func closeLeaderboard() {
        coordinator.close()
    }

}
