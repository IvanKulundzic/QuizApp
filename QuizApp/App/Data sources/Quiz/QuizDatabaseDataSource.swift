import Foundation
import RealmSwift

protocol QuizDatabaseDataSourceProtocol {

    func save(_ quizzes: [QuizDatabaseModel])

    func fetchQuizzes() -> [QuizDatabaseModel]

}

final class QuizDatabaseDataSource: QuizDatabaseDataSourceProtocol {

    private let realmManager: RealmManagerProtocol

    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }

    func save(_ quizzes: [QuizDatabaseModel]) {
        realmManager.write(quizzes: quizzes)
    }

    func fetchQuizzes() -> [QuizDatabaseModel] {
        realmManager.fetchQuizzes()
    }

}
