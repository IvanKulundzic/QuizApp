import Foundation

struct NetworkingConstants {

    static let baseUrl = "https://five-ios-quiz-app.herokuapp.com/"

}

enum HTTPRequestMethods: String {

    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"

}
