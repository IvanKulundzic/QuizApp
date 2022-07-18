import Foundation

protocol NetworkServiceProtocol {

    func executeUrlRequest<T: Codable>(_ request: URLRequest) async throws -> T

}

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

final class NetworkService: NetworkServiceProtocol {

    func executeUrlRequest<T: Codable>(_ request: URLRequest) async throws -> T {
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw RequestError.serverError
        }

        guard let response = response as? HTTPURLResponse else {
            throw RequestError.responseError
        }

        guard (200...299).contains(response.statusCode) else {
            switch response.statusCode {
            case 400:
                throw RequestError.badRequest
            case 401:
                throw RequestError.unauthorized
            case 403:
                throw RequestError.forbidden
            case 404:
                throw RequestError.notFound
            default:
                throw RequestError.unknown
            }
        }

        guard let value = try? JSONDecoder().decode(T.self, from: data) else {
            throw RequestError.dataDecodingError
        }

        return value
    }

}
