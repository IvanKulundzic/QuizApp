import RealmSwift

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

    init(from repoModel: QuestionRepositoryModel) {
        self.id = repoModel.id
        self.question = repoModel.question
        self.correctAnswerId = repoModel.correctAnswerId
        self.answers = repoModel.answers
    }

}

struct AnswerModel: Codable {

    let id: Int
    let answer: String

}

struct QuestionRepositoryModel {

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
