enum CategoryModel: String {

    case geography
    case movies
    case music
    case sport

    init(from category: CategoryDataModel) {
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

    init(from category: CategoryViewModel) {
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
