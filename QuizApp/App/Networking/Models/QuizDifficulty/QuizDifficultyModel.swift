enum QuizDifficultyModel: String {

    case easy
    case normal
    case hard

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
