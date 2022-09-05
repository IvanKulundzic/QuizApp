struct QuizNetworkModel: Codable {

    let id: Int
    let name: String
    let description: String
    let category: CategoryNetworkModel
    let difficulty: QuizDifficultyNetworkModel
    let numberOfQuestions: Int
    let imageUrl: String

}
