import RealmSwift

protocol RealmManagerProtocol {

    func write(quizzes: [QuizDatabaseModel])

    func fetchQuizzes() -> Results<QuizDatabaseModel>

    func delete<T: Object>(_ object: T)

}

final class RealmManager: RealmManagerProtocol {

    // swiftlint:disable force_try
    let realm = try! Realm()
    // swiftlint:enable force_try

    func write(quizzes: [QuizDatabaseModel]) {
        do {
            try realm.write {
                realm.add(quizzes)
            }
        } catch {
            print("Error writing to database, \(error.localizedDescription)")
        }
    }

    func fetchQuizzes() -> Results<QuizDatabaseModel> {
        return realm.objects(QuizDatabaseModel.self)
    }

    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleting object, \(error.localizedDescription)")
        }
    }

}
