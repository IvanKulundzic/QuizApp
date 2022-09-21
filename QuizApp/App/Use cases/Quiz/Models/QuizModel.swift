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

}
