import Foundation

enum RequestError: Error {

    case invalidUrl
    case clientError
    case responseError
    case serverError
    case noData
    case dataDecodingError
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case unknown

}
