struct QuestionModel {

    let id: Int
    let question: String
    let correctAnswerId: Int
    let answers: [AnswerModel]

    init(from model: QuestionDataModel) {
        self.id = model.id
        self.question = model.question
        self.correctAnswerId = model.correctAnswerId
        self.answers = model.answers
    }

}

struct AnswerModel: Codable {

    let id: Int
    let answer: String

}
