import Foundation

enum APIError: Error {
    case unknown
    case unreachable
    case failedRequest
    case invalidResponse
}
