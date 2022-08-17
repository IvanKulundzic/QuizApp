struct QuizNetworkModel: Codable {

    let id: Int
    let name: String
    let description: String
    let category: CategoryNetworkModel
    let difficulty: QuizDifficulty
    let numberOfQuestions: Int
    let imageUrl: String

}

enum QuizDifficulty: String, Codable {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

}
