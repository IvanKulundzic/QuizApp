struct QuizRepositoryModel {

    let id: Int
    let name: String
    let description: String
    let category: CategoryModel
    let difficulty: QuizDifficultyModel
    let numberOfQuestions: Int
    let imageUrl: String

    init(from model: QuizDatabaseModel) {
        self.id = model.id
        self.name = model.name
        self.description = model.desc
        self.category = CategoryModel(rawValue: model.category)!
        self.difficulty = QuizDifficultyModel(rawValue: model.difficulty)!
        self.numberOfQuestions  = model.numberOfQuestions
        self.imageUrl = model.imageUrl

    }

    init(from model: QuizDataModel) {
        self.id = model.id
        self.name = model.name
        self.description = model.description
        self.category = CategoryModel(from: model.category)
        self.difficulty = QuizDifficultyModel(from: model.difficulty)
        self.numberOfQuestions  = model.numberOfQuestions
        self.imageUrl = model.imageUrl
    }
}
