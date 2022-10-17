import Foundation
import RealmSwift

protocol QuizDatabaseDataSourceProtocol {

    func save(quizzes: [QuizDatabaseModel])

    func fetchQuizzes() -> Results<QuizDatabaseModel>

}

final class QuizDatabaseDataSource: QuizDatabaseDataSourceProtocol {

    private let realmManager: RealmManagerProtocol

    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }

    func save(quizzes: [QuizDatabaseModel]) {
        realmManager.write(quizzes: quizzes)
    }

    func fetchQuizzes() -> Results<QuizDatabaseModel> {
        realmManager.fetchQuizzes()
    }

}
