import Foundation

final class QuizViewModel {

    var quizCategories: [Category] {
        let categories = [
            Category(name: "Geography"),
            Category(name: "Movies"),
            Category(name: "Music"),
            Category(name: "Sport")
        ]
        return categories
    }

}
