enum CategoryDataModel: String {

    case geography = "GEOGRAPHY"
    case movies = "MOVIES"
    case music = "MUSIC"
    case sport = "SPORT"

    init(from category: CategoryNetworkModel) {
        switch category {
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
