protocol QuizRepositoryProtocol {
    
    func fetchQuizzes() async -> [QuizRepositoryModel]
    
    func fetchQuizzes(for category: CategoryModel) async -> [QuizRepositoryModel]
    
    func getQuestions(for quizId: Int) async -> [QuestionRepositoryModel]
    
    func saveQuizzes(_ quizzes: [QuizDatabaseModel])
    
}

final class QuizRepository: QuizRepositoryProtocol {
    
    private let networkDataSource: QuizNetworkDataSourceProtocol
    private let databaseDataSouce: QuizDatabaseDataSourceProtocol
    
    init(networkDataSource: QuizNetworkDataSourceProtocol, databaseDataSouce: QuizDatabaseDataSourceProtocol) {
        self.networkDataSource = networkDataSource
        self.databaseDataSouce = databaseDataSouce
    }
    
    @MainActor
    func fetchQuizzes() async -> [QuizRepositoryModel] {
        do {
            let quizzes = try await networkDataSource.fetchQuizes()
                .map { QuizRepositoryModel(from: $0) }
            let quizzesToSave = try await networkDataSource.fetchQuizes()
                .map { QuizDatabaseModel(from: $0)}
            saveQuizzes(quizzesToSave)
            return quizzes
        } catch {
            return databaseDataSouce.fetchQuizzes()
                .map { QuizRepositoryModel(from: $0) }
        }
    }
    
    func fetchQuizzes(for category: CategoryModel) async -> [QuizRepositoryModel] {
        do {
            return try await networkDataSource.fetchQuizes(for: CategoryDataModel(from: category))
                .map { QuizRepositoryModel(from: $0) }
        } catch {
            return databaseDataSouce.fetchQuizzes()
                .map { QuizRepositoryModel(from: $0) }
        }
    }
    
    func getQuestions(for quizId: Int) async -> [QuestionRepositoryModel] {
        do {
            return try await networkDataSource.getQuestions(for: quizId)
                .map { QuestionRepositoryModel(from: $0) }
        } catch {
            print("Error fetching questions, \(error.localizedDescription)")
            return []
        }
    }
    
    func saveQuizzes(_ quizzes: [QuizDatabaseModel]) {
        databaseDataSouce.save(quizzes)
    }
    
}
