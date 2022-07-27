import Foundation

final class QuizViewModel {

    var quizCategories: [Category] {
        let categories = [
            Category(from: CategoryNetworkModel.geography),
            Category(from: CategoryNetworkModel.movies),
            Category(from: CategoryNetworkModel.sport),
            Category(from: CategoryNetworkModel.music)
        ]
        return categories
    }

}
