enum QuizDifficultyNetworkModel: String, Codable {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

}

enum QuizDifficultyDataModel: String {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

    init(from model: QuizDifficultyNetworkModel) {
        switch model {
        case .easy:
            self = .easy
        case .normal:
            self = .normal
        case .hard:
            self = .hard
        }
    }

}

enum QuizDifficultyModel: String {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

    init(from model: QuizDifficultyDataModel) {
        switch model {
        case .easy:
            self = .easy
        case .normal:
            self = .normal
        case .hard:
            self = .hard
        }
    }

}

enum QuizDifficultyViewModel: String {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

    init(from model: QuizDifficultyModel) {
        switch model {
        case .easy:
            self = .easy
        case .normal:
            self = .normal
        case .hard:
            self = .hard
        }
    }

}
