struct StartQuizSessionResponse: Codable {

    let sessionId: String
    let questions: [QuestionNetworkModel]

}
