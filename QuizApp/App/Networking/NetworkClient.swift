import Foundation

protocol NetworkClientProtocol {

    func executeUrlRequest<T: Codable>(_ request: URLRequest) async throws -> T

    func executeUrlRequest(_ request: URLRequest) async throws

}

final class NetworkClient: NetworkClientProtocol {

    func executeUrlRequest<T: Codable>(_ request: URLRequest) async throws -> T {
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw RequestError.serverError
        }

        if
            let httpResponse = response as? HTTPURLResponse,
            (300...503).contains(httpResponse.statusCode)
        {
            switch httpResponse.statusCode {
            case 401:
                throw RequestError.unauthorized
            case 403:
                throw RequestError.forbidden
            case 404:
                throw RequestError.notFound
            default:
                throw RequestError.serverError
            }
        }

        guard let value = try? JSONDecoder().decode(T.self, from: data) else {
            throw RequestError.dataDecodingError
        }

        return value
    }

    func executeUrlRequest(_ request: URLRequest) async throws {
        guard let (_, response) = try? await URLSession.shared.data(for: request) else {
            throw RequestError.serverError
        }

        if
            let httpResponse = response as? HTTPURLResponse,
            (300...503).contains(httpResponse.statusCode)
        {
            switch httpResponse.statusCode {
            case 401:
                throw RequestError.unauthorized
            case 403:
                throw RequestError.forbidden
            case 404:
                throw RequestError.notFound
            default:
                throw RequestError.serverError
            }
        }
    }

}
