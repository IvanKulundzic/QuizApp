import RealmSwift

protocol RealmManagerProtocol {

    func write(quizzes: [QuizDatabaseModel])

    func fetchQuizzes() -> [QuizDatabaseModel]

    func delete(_ object: QuizDatabaseModel)

}

final class RealmManager: RealmManagerProtocol {

    // swiftlint:disable force_try
    let realm = try! Realm()
    // swiftlint:enable force_try

    func write(quizzes: [QuizDatabaseModel]) {
        do {
            try realm.write {
                realm.add(quizzes, update: .modified)
            }
        } catch {
            print("Error writing to database, \(error.localizedDescription)")
        }
    }

    func fetchQuizzes() -> [QuizDatabaseModel] {
        Array(realm.objects(QuizDatabaseModel.self))
    }

    func delete(_ object: QuizDatabaseModel) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleting object, \(error.localizedDescription)")
        }
    }

}
