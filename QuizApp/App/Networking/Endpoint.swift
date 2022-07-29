import Foundation

enum EndpointType {

    case login
    case check
    case account
    case quizList

}

struct Endpoint {

    var type: EndpointType

    init(type: EndpointType) {
        self.type = type
    }

    var path: String {
        switch type {
        case .login:
            return "\(NetworkingConstants.baseUrl)api/v1/login"
        case .check:
            return "\(NetworkingConstants.baseUrl)api/v1/check"
        case .account:
            return "\(NetworkingConstants.baseUrl)api/v1/account"
        case .quizList:
            return "\(NetworkingConstants.baseUrl)api/v1/quiz/list"
        }
    }

}
