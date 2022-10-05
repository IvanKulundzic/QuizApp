struct QuestionNetworkModel: Codable {

    let id: Int
    let question: String
    let correctAnswerId: Int
    let answers: [AnswerModel]

}
