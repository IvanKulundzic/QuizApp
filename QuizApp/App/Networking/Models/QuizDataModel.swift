struct QuizDataModel {

    let id: Int
    let name: String
    let description: String
    let category: CategoryDataModel
    let difficulty: QuizDifficulty
    let numberOfQuestions: Int
    let imageUrl: String

    init(from model: QuizNetworkModel) {
        self.id = model.id
        self.name = model.name
        self.description = model.description
        self.category = CategoryDataModel(from: model.category)
        self.difficulty = model.difficulty
        self.numberOfQuestions = model.numberOfQuestions
        self.imageUrl = model.imageUrl
    }
}
