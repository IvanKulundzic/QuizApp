struct QuestionDataModel {

    let id: Int
    let question: String
    let correctAnswerId: Int
    let answers: [AnswerModel]

    init(from model: QuestionNetworkModel) {
        self.id = model.id
        self.question = model.question
        self.correctAnswerId = model.correctAnswerId
        self.answers = model.answers
    }

}
