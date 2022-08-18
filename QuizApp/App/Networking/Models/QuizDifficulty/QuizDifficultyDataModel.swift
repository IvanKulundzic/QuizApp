enum QuizDifficultyDataModel: String {

    case easy
    case normal
    case hard

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
