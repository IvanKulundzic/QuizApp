struct QuizViewModel {

    let name: String
    let description: String
    let category: CategoryViewModel
    let difficulty: QuizDifficultyViewModel
    let numberOfQuestions: Int
    let imageUrl: String

    init(from model: QuizModel) {
        self.name = model.name
        self.description = model.description
        self.category = CategoryViewModel(from: model.category)
        self.difficulty = QuizDifficultyViewModel(from: model.difficulty)
        self.numberOfQuestions = model.numberOfQuestions
        self.imageUrl = model.imageUrl
    }

}
