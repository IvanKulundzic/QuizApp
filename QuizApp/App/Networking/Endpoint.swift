import Foundation

enum EndpointType {

    case login

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
        }
    }

}

