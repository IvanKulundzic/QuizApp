enum CategoryModel: String {

    case all
    case geography
    case movies
    case music
    case sport

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

    init(from category: CategoryViewModel) {
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

    init(from category: Category) {
        switch category {
        case .all:
            self = .all
        case .sport:
            self = .sport
        case .movies:
            self = .movies
        case .music:
            self = .music
        case .geography:
            self = .geography
        }
    }

}
