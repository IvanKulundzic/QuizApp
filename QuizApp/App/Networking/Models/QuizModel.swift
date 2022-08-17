struct QuizModel {

    let name: String
    let description: String
    let category: CategoryModel
    let difficulty: QuizDifficulty
    let numberOfQuestions: Int
    let imageUrl: String

    init(from dataModel: QuizDataModel) {
        self.name = dataModel.name
        self.description = dataModel.description
        self.category = CategoryModel(from: dataModel.category)
        self.difficulty = dataModel.difficulty
        self.numberOfQuestions = dataModel.numberOfQuestions
        self.imageUrl = dataModel.imageUrl
    }

}
