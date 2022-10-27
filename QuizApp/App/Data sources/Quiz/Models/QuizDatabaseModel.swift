import RealmSwift

class QuizDatabaseModel: Object {

    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var desc: String
    @Persisted var category: String
    @Persisted var difficulty: String
    @Persisted var numberOfQuestions: Int
    @Persisted var imageUrl: String

    convenience init(from model: QuizDataModel) {
        self.init()

        self.id = model.id
        self.name = model.name
        self.desc = model.description
        self.category = model.category.rawValue
        self.difficulty = model.difficulty.rawValue
        self.numberOfQuestions = model.numberOfQuestions
        self.imageUrl = model.imageUrl
    }
}
