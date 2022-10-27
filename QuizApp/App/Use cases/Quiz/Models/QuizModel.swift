struct QuizModel {

    let id: Int
    let name: String
    let description: String
    let category: CategoryModel
    let difficulty: QuizDifficultyModel
    let numberOfQuestions: Int
    let imageUrl: String

    init(from dataModel: QuizDataModel) {
        self.id = dataModel.id
        self.name = dataModel.name
        self.description = dataModel.description
        self.category = CategoryModel(from: dataModel.category)
        self.difficulty = QuizDifficultyModel(from: dataModel.difficulty)
        self.numberOfQuestions = dataModel.numberOfQuestions
        self.imageUrl = dataModel.imageUrl
    }

    init(from databaseModel: QuizDatabaseModel) {
        self.id = databaseModel.id
        self.name = databaseModel.name
        self.description = databaseModel.description
        self.category = CategoryModel(rawValue: databaseModel.category)!
        self.difficulty = QuizDifficultyModel(rawValue: databaseModel.difficulty)!
        self.numberOfQuestions = databaseModel.numberOfQuestions
        self.imageUrl = databaseModel.imageUrl
    }

    init(from repoModel: QuizRepositoryModel) {
        self.id = repoModel.id
        self.name = repoModel.name
        self.description = repoModel.description
        self.category = repoModel.category
        self.difficulty = repoModel.difficulty
        self.numberOfQuestions = repoModel.numberOfQuestions
        self.imageUrl = repoModel.imageUrl
    }

}
