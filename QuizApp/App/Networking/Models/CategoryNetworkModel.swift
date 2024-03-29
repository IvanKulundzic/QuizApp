enum CategoryNetworkModel: String, Codable {

    case all
    case geography = "GEOGRAPHY"
    case movies = "MOVIES"
    case music = "MUSIC"
    case sport = "SPORT"

    init(from category: CategoryDataModel) {
        switch category {
        case .all:
            self = .all
        case .geography:
            self = .geography
        case .movies:
            self = .movies
        case .music:
            self = .music
        case .sport:
            self = .sport
        }
    }

}
