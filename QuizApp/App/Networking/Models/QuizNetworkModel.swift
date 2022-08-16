struct QuizNetworkModel: Codable {

    let id: Int
    let name: String
    let description: String
    let category: CategoryNetworkModel
    let difficulty: String
    let numberOfQuestions: Int
    let imageUrl: String

}
