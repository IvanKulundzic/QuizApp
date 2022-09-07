enum CategoryDataModel: String {

    case all = "ALL"
    case geography = "GEOGRAPHY"
    case movies = "MOVIES"
    case music = "MUSIC"
    case sport = "SPORT"

    init(from category: CategoryNetworkModel) {
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

    init(from category: CategoryModel) {
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
