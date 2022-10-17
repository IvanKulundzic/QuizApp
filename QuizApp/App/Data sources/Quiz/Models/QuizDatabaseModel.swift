import RealmSwift

class QuizDatabaseModel: Object {

    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var desc: String
    @Persisted var category: String
    @Persisted var difficulty: String
    @Persisted var numberOfQuestions: Int
    @Persisted var imageUrl: String

}
